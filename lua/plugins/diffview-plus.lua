return {
  'dlyongemallo/diffview-plus.nvim',
  version = '*',
  main = 'diffview',
  opts = {
    view = {
      default = { layout = 'diff1_inline' },
      cycle_layouts = {
        default = {
          'diff1_inline',
          'diff2_horizontal',
          'diff2_vertical',
        },
      },
    },
  },
  cmd = {
    'DiffviewToggle',
  },
  keys = {
    { '<leader>dv', '<cmd>DiffviewToggle<CR>', desc = 'Diffview Toggle' },
  },
}
