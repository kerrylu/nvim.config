return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',

  config = function()
    require('nvim-treesitter').setup {
      ensure_installed = { "bash", "c", "java", "html", "javascript", "jsdoc", "json", "lua", "luadoc", "luap", "markdown", "markdown_inline", "python", "query", "regex", "tsx", "typescript", "vim", "vimdoc", "yaml" },
      auto_install = true,
    }
  end
}
