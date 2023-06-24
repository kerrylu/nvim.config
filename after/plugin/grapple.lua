require("grapple")
vim.keymap.set("n", "<leader>m", require("grapple").toggle)
vim.keymap.set("n", "<leader>t", require("grapple").tag)
vim.keymap.set("n", "<leader>u", require("grapple").untag)
vim.keymap.set("n", "<leader>pt", require("grapple").popup_tags)

require("lualine").setup({
    sections = {
        lualine_x = {
            {
                require("grapple").key,
                cond = require("grapple").exists
            }
        }
    }
})