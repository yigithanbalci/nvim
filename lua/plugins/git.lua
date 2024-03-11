return {
  {
    'tpope/vim-fugitive',
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    config = function()
      require('gitsigns').setup()

      vim.keymap.set('n', '<leader>gsp', ':Gitsigns preview_hunk<CR>', { desc = 'Gitsigns Preview Hunk' })
      vim.keymap.set('n', '<leader>gst', ':Gitsigns toggle_current_line_blame<CR>', { desc = 'Gitsigns Toggle Currentline Blame' })
      vim.keymap.set('n', '<leader>gp', ':Git pull<CR>', { desc = 'Git Pull' })
      vim.keymap.set('n', '<leader>gP', ':Git push<CR>', { desc = 'Git Push' })
      vim.keymap.set('n', '<leader>gA', ':Git add .<CR>', { desc = 'Git Add All' })
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git Commit' })
      vim.keymap.set('n', '<leader>gE', ':Git <CR>', { desc = 'Git Page for Manual Editing' })
    end,
  },
}
