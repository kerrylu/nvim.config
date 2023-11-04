require("modules/remap")

-- Setup language servers.
local lspconfig = require('lspconfig')
-- python
lspconfig.pyright.setup {}
-- c, cpp, objc, objcpp, cuda, proto
lspconfig.clangd.setup{
    cmd = {
        "clangd",
        "--clang-tidy",
        "--background-index",
        "--suggest-missing-includes",
        "--compile-commands-dir=~/.config/clangd/config.yaml",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto", "hpp" },
}

-- Global mappings.

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- Overrides defaults
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  end,
})