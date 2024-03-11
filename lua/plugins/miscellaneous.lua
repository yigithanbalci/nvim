return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    -- Tab Page integration plugin
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
  },
}
