#!/usr/bin/env bash
# council.sh — drive `codex exec` as a read-only consulting sub-agent.
#
# Subcommands:
#   start [opts] "<question>"   Begin a new consultation (fresh session id).
#   ask   [opts] "<question>"   Continue the current consultation (resume by id).
#   id    [--session NAME]      Print the stored thread id for a session.
#   list                        List known sessions and their ids.
#   reset [--session NAME]      Forget a session (does not delete codex history).
#
# Options (start/ask):
#   --session NAME      Named slot so several consultations can run in parallel (default: "default").
#   --dir DIR           Working root codex reads from (default: current directory).
#   --model MODEL       Override the codex model (e.g. gpt-5.6-sol).
#   --effort LEVEL      Reasoning effort (minimal|low|medium|high). Forces model_reasoning_effort.
#   --role-file FILE    File whose contents become the role-init preamble (start only).
#   --prompt-file FILE  Read the question from FILE instead of argv (use for large payloads).
#   --timeout SECS      Idle-stall timeout in seconds (default: 330 = 5.5 min).
#
# Behavior:
#   * Sandbox is forced to read-only (codex may read/analyze but never mutate).
#   * On `start`, a role-init preamble is prepended to the first question to frame the sub-agent.
#   * The thread id is captured from the JSON stream and persisted so `ask` resumes the same
#     session — context carries over without re-sending it.
#   * An idle watcher kills a hung call cleanly if the JSON stream stops growing for --timeout
#     seconds (exit 124), instead of blocking the caller forever.
#
# Only the sub-agent's final answer is printed to stdout. Diagnostics go to stderr.

set -uo pipefail

# ---- config / paths ---------------------------------------------------------
STATE_HOME="${COUNCIL_HOME:-$HOME/.council}"
SESS_DIR="$STATE_HOME/sessions"
RUN_DIR="$STATE_HOME/runs"
mkdir -p "$SESS_DIR" "$RUN_DIR"

DEFAULT_TIMEOUT="${COUNCIL_IDLE_TIMEOUT:-330}"   # seconds of no new output before we abort
POLL_INTERVAL=5                                # how often the watcher checks for growth

err()  { printf '%s\n' "$*" >&2; }
die()  { err "council: $*"; exit 2; }

# Portable file size in bytes (macOS vs GNU stat).
filesize() { stat -f%z "$1" 2>/dev/null || stat -c%s "$1" 2>/dev/null || echo 0; }

# The default role-init preamble. Override per-call with --role-file.
default_role() {
  cat <<'ROLE'
You are Codex, acting as an expert software engineering consultant collaborating with another
AI coding agent. You give a rigorous, independent technical second opinion.

Operating constraints:
- You are in a READ-ONLY sandbox: you may read, search, and analyze files, but you cannot modify
  anything, run mutating commands, or install packages. Do not attempt writes.
- Be precise and concrete. When you reference code, cite it as file:line. Prefer specifics over
  generalities.
- If you are uncertain or lack the information to answer, say so plainly rather than guessing.
- This is a multi-turn consultation: later messages continue this same context, so you need not
  restate earlier reasoning unless asked.

Answer the question that follows.
ROLE
}

# ---- argument parsing -------------------------------------------------------
SUB="${1:-}"; shift || true
[ -n "$SUB" ] || die "missing subcommand (start|ask|id|list|reset)"

SESSION="default"
WORKDIR="$PWD"
MODEL=""
EFFORT=""
ROLE_FILE=""
PROMPT_FILE=""
TIMEOUT="$DEFAULT_TIMEOUT"
POSITIONAL=()

while [ $# -gt 0 ]; do
  case "$1" in
    --session)     SESSION="${2:-}"; shift 2 ;;
    --dir)         WORKDIR="${2:-}"; shift 2 ;;
    --model)       MODEL="${2:-}";   shift 2 ;;
    --effort)      EFFORT="${2:-}";  shift 2 ;;
    --role-file)   ROLE_FILE="${2:-}"; shift 2 ;;
    --prompt-file) PROMPT_FILE="${2:-}"; shift 2 ;;
    --timeout)     TIMEOUT="${2:-}"; shift 2 ;;
    --) shift; while [ $# -gt 0 ]; do POSITIONAL+=("$1"); shift; done ;;
    -*) die "unknown option: $1" ;;
    *)  POSITIONAL+=("$1"); shift ;;
  esac
done

ID_FILE="$SESS_DIR/$SESSION.id"
DIR_FILE="$SESS_DIR/$SESSION.dir"

# ---- non-run subcommands ----------------------------------------------------
case "$SUB" in
  id)
    [ -f "$ID_FILE" ] || die "no active session named '$SESSION'"
    cat "$ID_FILE"; exit 0 ;;
  list)
    shopt -s nullglob
    found=0
    for f in "$SESS_DIR"/*.id; do
      found=1; name="$(basename "$f" .id)"
      printf '%-20s %s\n' "$name" "$(cat "$f")"
    done
    [ "$found" -eq 1 ] || err "(no sessions)"
    exit 0 ;;
  reset)
    rm -f "$ID_FILE" "$DIR_FILE"; err "session '$SESSION' reset"; exit 0 ;;
  start|ask) : ;;
  *) die "unknown subcommand '$SUB'" ;;
esac

# ---- assemble the prompt ----------------------------------------------------
# Question comes from --prompt-file (preferred for large payloads) or positional args.
if [ -n "$PROMPT_FILE" ]; then
  [ -f "$PROMPT_FILE" ] || die "prompt file not found: $PROMPT_FILE"
  QUESTION="$(cat "$PROMPT_FILE")"
  [ "${#POSITIONAL[@]}" -ge 1 ] && QUESTION="$QUESTION"$'\n\n'"${POSITIONAL[*]}"
else
  [ "${#POSITIONAL[@]}" -ge 1 ] || die "$SUB needs a question argument (or --prompt-file)"
  QUESTION="${POSITIONAL[*]}"
fi

if [ "$SUB" = "start" ]; then
  if [ -n "$ROLE_FILE" ]; then
    [ -f "$ROLE_FILE" ] || die "role file not found: $ROLE_FILE"
    ROLE="$(cat "$ROLE_FILE")"
  else
    ROLE="$(default_role)"
  fi
  PROMPT="$ROLE"$'\n\n---\n\n'"$QUESTION"
else
  [ -f "$ID_FILE" ] || die "no active session named '$SESSION' — run 'start' first"
  THREAD_ID="$(cat "$ID_FILE")"
  [ -f "$DIR_FILE" ] && WORKDIR="$(cat "$DIR_FILE")"
  PROMPT="$QUESTION"
fi

[ -d "$WORKDIR" ] || die "working dir does not exist: $WORKDIR"

# ---- build the codex command ------------------------------------------------
STREAM="$(mktemp "$RUN_DIR/stream.XXXXXX.jsonl")"
LASTMSG="$(mktemp "$RUN_DIR/last.XXXXXX.txt")"
cleanup_files() { rm -f "$STREAM" "$LASTMSG"; }
trap cleanup_files EXIT

CMD=(codex exec)
if [ "$SUB" = "ask" ]; then
  # `resume` has no -C flag; it reuses the working dir from `start`.
  CMD+=(resume "$THREAD_ID")
fi
CMD+=(--json
      -c sandbox_mode="read-only"
      --skip-git-repo-check
      -o "$LASTMSG")
[ "$SUB" = "start" ] && CMD+=(-C "$WORKDIR")
[ -n "$MODEL" ]  && CMD+=(-m "$MODEL")
[ -n "$EFFORT" ] && CMD+=(-c model_reasoning_effort="$EFFORT")
CMD+=("$PROMPT")

# ---- launch + idle watcher --------------------------------------------------
# stdin from /dev/null so codex never blocks waiting on a stdin block.
"${CMD[@]}" </dev/null >"$STREAM" 2>>"$STREAM" &
CPID=$!

terminate() {
  # Best-effort clean shutdown: TERM the child and any descendants, then KILL.
  pkill -TERM -P "$CPID" 2>/dev/null
  kill -TERM "$CPID" 2>/dev/null
  for _ in 1 2 3 4 5 6; do kill -0 "$CPID" 2>/dev/null || return 0; sleep 0.5; done
  pkill -KILL -P "$CPID" 2>/dev/null
  kill -KILL "$CPID" 2>/dev/null
}
# If this wrapper is itself interrupted, don't leave codex running.
trap 'terminate; cleanup_files; exit 130' INT TERM

last_size=-1
last_change="$(date +%s)"
timed_out=0
while kill -0 "$CPID" 2>/dev/null; do
  sleep "$POLL_INTERVAL"
  size="$(filesize "$STREAM")"
  now="$(date +%s)"
  if [ "$size" != "$last_size" ]; then
    last_size="$size"; last_change="$now"
  elif [ $(( now - last_change )) -ge "$TIMEOUT" ]; then
    timed_out=1
    err "council: no output for ${TIMEOUT}s — aborting hung call."
    terminate
    break
  fi
done

wait "$CPID" 2>/dev/null
RC=$?

# ---- persist session id (start) ---------------------------------------------
if [ "$SUB" = "start" ]; then
  SID="$(grep -m1 '"type":"thread.started"' "$STREAM" \
          | sed -E 's/.*"thread_id":"([^"]+)".*/\1/')"
  if [ -n "$SID" ]; then
    printf '%s' "$SID" > "$ID_FILE"
    printf '%s' "$WORKDIR" > "$DIR_FILE"
    err "council: session '$SESSION' -> $SID"
  else
    err "council: warning — could not capture thread id from stream."
  fi
fi

# ---- emit the final answer --------------------------------------------------
if [ "$timed_out" -eq 1 ]; then
  err "council: consultation aborted after idle timeout."
  exit 124
fi

if [ -s "$LASTMSG" ]; then
  cat "$LASTMSG"
else
  # Fallback: pull the last agent_message out of the JSON stream.
  MSG="$(grep '"type":"item.completed"' "$STREAM" \
          | grep '"agent_message"' | tail -1 \
          | python3 -c 'import sys,json
line=sys.stdin.readline().strip()
try:
    print(json.loads(line)["item"]["text"])
except Exception:
    pass' 2>/dev/null)"
  if [ -n "$MSG" ]; then
    printf '%s\n' "$MSG"
  else
    err "council: no answer captured (codex exit $RC). Raw stream tail:"
    tail -5 "$STREAM" >&2
    exit "${RC:-1}"
  fi
fi

exit "$RC"
