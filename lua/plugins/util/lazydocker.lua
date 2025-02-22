return {
  "crnvl96/lazydocker.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    vim.keymap.set(
      "n",
      "<leader>k",
      "<cmd>LazyDocker<CR>",
      { desc = "Toggle LazyDocker", noremap = true, silent = true }
    )
    return opts
  end, -- automatically calls `require("lazydocker").setup()`,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
