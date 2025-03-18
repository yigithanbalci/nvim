return {
  {
    "vimpostor/vim-tpipeline",
    config = function()
      -- Tpipeline for Tmux and Vim status line to merge
      vim.g.tpipeline_autoembed = 1
      vim.g.tpipeline_restore = 1
      vim.g.tpipeline_clearstl = 1
    end,
  },
}
