-- Avante.nvim: Cursor-style AI sidebar powered by Claude.
-- Requires ANTHROPIC_API_KEY to be set in your environment.
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- always use latest
  opts = {
    provider = "claude",
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-sonnet-4-6",
      timeout = 30000,
      temperature = 0,
      max_tokens = 8096,
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    windows = {
      position = "right",
      wrap = true,
      width = 35,
      sidebar_header = {
        enabled = true,
        align = "center",
        rounded = true,
      },
    },
    diff = {
      autojump = true,
      list_opener = "copen",
    },
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.icons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
