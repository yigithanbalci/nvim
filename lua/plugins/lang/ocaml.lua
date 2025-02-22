return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "ocaml",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "ocamlearlybird",
      },
    },
  },
}
