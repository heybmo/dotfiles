# Security-hardened Dockerfile for Claude CLI
# Multi-stage build for minimal attack surface
FROM alpine:3.22

RUN apk update && apk upgrade

# Check https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md, OR:
# Use $(curl -s https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/latest | grep -iE '(\d.\d.\d).*');
ARG CLAUDE_CODE_VERSION
ARG claude_group=claude_group
ARG claude_username=claude
ARG my_username=$USER

# Security: Create non-root user with minimal privileges
RUN addgroup -g 1001 -S $claude_group && \
    adduser -S -D -u 1001 -G $claude_group $claude_username \
    adduser -S -D -u 1001 -G $claude_group $my_username \
    && mkdir -p /home/$my_username/.config \
    && chown -R $my_username:$my_username /home/$my_username

# Install build dependencies
RUN apk add --no-cache --update \
    git \
    less \
    fzf \
    bash \
    jq \
    neovim \
    nodejs \
    python3 \
    make \
    clang \
    iptables \
    ip6tables \
    ipset \
    bind-tools \
    util-linux \
    su-exec \
    sudo \
    curl \
    && rm -rf /var/cache/apk/*

RUN apk add --no-cache --update npm \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /usr/local/share/npm-global && \
    chown -R $my_username:$claude_group /usr/local/share

RUN mkdir -p /home/.claudeconf \
    && chown -R $my_username:$claude_group /home/.claudeconf/

# Copy over Claude instructions and general persona info to environment
COPY .claude.local/docs/ /home/.claudeconf/

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE='/commandhistory/.bash_history'" \
    && mkdir /commandhistory \
    && touch /commandhistory/.bash_history \
    && chown -R $my_username:$claude_group /commandhistory

ENV DEVCONTAINER=true

# Create workspace
RUN mkdir -p /workspace /home/$my_username/.claude && \
    chown -R $my_username:$claude_group /workspace /home/$my_username/.claude

RUN touch /home/$my_username/.bashrc \
    && echo -e 'alias vim="nvim";\nalias l="ls -alF";' >> /home/$my_username/.bashrc \
    && echo 'export PATH=$PATH:/usr/local/share/npm-global/bin' >> /home/$my_username/.bashrc

WORKDIR /workspace

ENV SHELL=/bin/bash
ENV EDITOR=nvim
ENV VISUAL=nvim
ENV ENABLE_FIREWALL=true

ENV NPM_CONFIG_PREFIX=/usr/local/share/npm-global
ENV PATH=$PATH:/usr/local/share/npm-global/bin

RUN chsh -s /bin/bash

# Install Claude
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}

# Copy firewall and entrypoint scripts
COPY .claude.local/init-claude-firewall.sh /usr/local/bin/
COPY .claude.local/claude-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-claude-firewall.sh /usr/local/bin/claude-entrypoint.sh

# Configure sudo for firewall initialization
RUN echo "claude ALL=(root) NOPASSWD:SETENV: /usr/local/bin/claude-entrypoint.sh" > /etc/sudoers.d/claude-firewall && \
    chmod 0440 /etc/sudoers.d/claude-firewall

# Add health check for firewall status
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f --connect-timeout 5 https://api.github.com/zen >/dev/null 2>&1 || exit 1

# Set default entrypoint
ENTRYPOINT ["/usr/local/bin/claude-entrypoint.sh"]
CMD ["claude"]

# Final security hardening
USER $my_username:$claude_group

LABEL description="Security-hardened Claude CLI container"
LABEL security.scan-policy="strict"
LABEL org.opencontainers.image.title="Secure Claude CLI"
LABEL org.opencontainers.image.description="Semi-minimal, security-hardened container for Claude CLI"


