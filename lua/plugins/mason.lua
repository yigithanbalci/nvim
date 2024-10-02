return {
  "williamboman/mason.nvim",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      "js-debug-adapter",
      "ocamlearlybird",
      -- Rust tools
      "codelldb",
      "rust-analyzer",
      "rustfmt",
      ----------------
      "markdownlint-cli2",
      "markdown-toc",
      -- Go tools
      "goimports",
      "gofumpt",
      "gomodifytags",
      "impl",
      "delve",
      -----------
    },
  },
}
