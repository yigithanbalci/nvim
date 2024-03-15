return {
  {
    "folke/which-key.nvim",
    opts = {
      plugins = { spelling = true },
      defaults = {
        ["<leader>h"] = { name = "+harpoon" },
      },
    },
  },
}
