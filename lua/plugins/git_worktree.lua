return {
  "polarmutex/git-worktree.nvim",
  version = "^2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function(_, opts)
    require("git-worktree").setup()
    require("telescope").load_extension("git_worktree")
    return opts
  end,
  keys = {
    {
      "<leader>gw",
      "",
      desc = "Git Worktrees",
    },
    {
      "<leader>gws",
      function()
        require("telescope").extensions.git_worktree.git_worktrees()
      end,
      desc = "Search Git Worktrees",
    },
    {
      "<leader>gwc",
      "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
      desc = "Create Git Worktree",
    },
  },
}
