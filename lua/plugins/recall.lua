return {
  "fnune/recall.nvim",
  version = "*",
  config = function()
    local recall = require("recall")

    recall.setup({})

    vim.keymap.set("n", "<leader>m", recall.toggle, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>]", recall.goto_next, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>[", recall.goto_prev, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>m<space>", recall.clear, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>ml", ":Telescope recall<CR>", { noremap = true, silent = true })
  end
}
