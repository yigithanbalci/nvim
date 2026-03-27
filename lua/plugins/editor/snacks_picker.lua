return {
  {
    "snacks.nvim",
    keys = {
      { "<leader>gd", false }, -- Disable LazyVim's snacks picker Git Diff so diffview.nvim owns <leader>gd
      { "<leader>gD", false }, -- Disable LazyVim's snacks picker Git Diff so diffview.nvim owns <leader>gD
    },
  },
}
