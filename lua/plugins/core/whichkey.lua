return {
  {
    "folke/which-key.nvim",
    opts = {
      plugins = { spelling = true },
      spec = {
        ["<leader>h"] = { name = "+harpoon" },
      },
      preset = "modern",
    },
  },
}
