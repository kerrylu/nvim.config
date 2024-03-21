return {
  url = "lukerry@git.amazon.com:pkg/NinjaHooks",
  branch = "mainline",
  lazy = false,
  dependencies = {
    {'neovim/nvim-lspconfig'},
  },
  config = function(plugin)
    vim.opt.rtp:prepend(plugin.dir .. "/configuration/vim/amazon/brazil-config")
    -- Make my own filetype thing to override neovim applying ".conf" file type.
    -- You may or may not need this depending on your setup.
    vim.filetype.add({
      filename = {
        ['Config'] = function()
          vim.b.brazil_package_Config = 1
          return 'brazil-config'
        end,
      },
    })

    local lspconfig = require 'lspconfig'
    local configs = require 'lspconfig.configs'

    -- Check if the config is already defined (useful when reloading this file)
    if not configs.barium then
        configs.barium = {
            default_config = {
                cmd = {'barium'};
                filetypes = {'brazil-config'};
                root_dir = function(fname)
                    return lspconfig.util.find_git_ancestor(fname)
                end;
                settings = {};
            };
        }
    end

    lspconfig.barium.setup {}
  end
}

