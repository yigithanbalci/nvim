return {
  "ernstwi/vim-secret",
  config = function(_, opts)
    return opts
  end,
  keys = {
    { "<leader>uk", "", desc = "+Secret" },
    { "<leader>uks", ":Secret<CR>", desc = "Enable Secret View" },
    { "<leader>ukS", ":Secret!<CR>", desc = "Disable Secret View" },
  },
}
