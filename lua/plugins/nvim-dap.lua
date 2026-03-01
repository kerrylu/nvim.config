return {
    'mfussenegger/nvim-dap',
    config = function()
        local dap = require('dap')
        vim.keymap.set("n", "<leader>db", function() require('dap').toggle_breakpoint() end, {desc = "[D]ap toggle [B]reakpoint"})
        vim.keymap.set("n", "<leader>dc", function() require('dap').continue() end, {desc = "[D]ap [C]ontinue debugger"})
    end
}
