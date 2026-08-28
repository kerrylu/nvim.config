return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  main = 'neo-tree',
  cmd = 'Neotree',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'disabled',
    },
  },
}
