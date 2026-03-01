return {
  "greggh/claude-code.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    window = {
      position = "vertical",
      split_ratio = 0.3,
    },
    keymaps = {
      toggle = { normal = "<leader>cc" },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.schedule(function()
          require("claude-code").toggle()
        end)
      end,
    })
  end,
}
