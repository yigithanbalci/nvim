return {
  "williamboman/mason.nvim",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      "js-debug-adapter",
      "ocamlearlybird",
      "codelldb",
      "rust-analyzer",
      "rustfmt",
      "markdownlint-cli2",
      "markdown-toc",
    },
  },
}
