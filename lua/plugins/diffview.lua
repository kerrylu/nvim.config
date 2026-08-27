return {
  'dlyongemallo/diffview-plus.nvim',
  version = '*',
  main = 'diffview',
  opts = {
    view = {
      default = { layout = 'diff1_inline' }
    },
  },
  cmd = {
    'DiffviewToggle',
  },
  keys = {
    { '<leader>dv', '<cmd>DiffviewToggle<CR>', desc = 'Diffview Toggle' },
  },
}
