return {
    'mfussenegger/nvim-dap',
    config = function()
        local dap = require('dap')
        dap.configurations.java = {
            {
                type = 'java';
                request = 'attach';
                name = "Debug (Attach) - Remote";
                hostName = "127.0.0.1";
                port = 5050;
            },
        }
        vim.keymap.set("n", "<leader>db", function() require('dap').toggle_breakpoint() end, {desc = "[D]ap toggle [B]reakpoint"})
        vim.keymap.set("n", "<leader>dc", function() require('dap').continue() end, {desc = "[D]ap [C]ontinue debugger"})
        vim.keymap.set("n", "<leader>jt", function() require'jdtls'.test_nearest_method() end, {desc = "[J]DTLS [T]est nearest method"})
    end
}
