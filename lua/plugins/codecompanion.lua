return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCLI",
    "CodeCompanionCmd",
  },
  keys = {
    {
      "<leader>cc",
      function()
        require("codecompanion").toggle_cli({ agent = "codex" })
      end,
      desc = "Toggle Codex chat",
    },
    {
      "<leader>ca",
      function()
        require("codecompanion").cli("#{this}", { agent = "codex", focus = false })
      end,
      mode = { "n", "v" },
      desc = "Add current context to Codex chat",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    interactions = {
      cli = {
        agent = "codex",
        agents = {
          codex = {
            cmd = "codex",
            args = { "--yolo" },
            description = "OpenAI Codex CLI",
            provider = "terminal",
          },
          claude_code = {
            cmd = "claude",
            args = {},
            description = "Claude Code CLI",
            provider = "terminal",
          },
        },
        opts = {
          auto_insert = true,
          reload = true,
        },
      },
    },
    display = {
      action_palette = {
        provider = "telescope",
      },
      cli = {
        window = {
          layout = "vertical",
          width = 0.5,
        },
      },
    },
  },
}
