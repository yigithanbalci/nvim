return {
  {
    "folke/which-key.nvim",
    opts = {
      plugins = { spelling = true },
      spec = {
        { "<leader>h", group = "harpoon" },
        { "<leader>gv", group = "vanilla (LazyVim Defaults)" },
      },
      preset = "modern",
    },
  },
}
