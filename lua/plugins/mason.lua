return {
  "williamboman/mason.nvim",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      -- C/C++ tools
      "cmakelang",
      "cmakelint",
      ----------------
      "js-debug-adapter",
      "ocamlearlybird",
      -- Rust tools
      "codelldb", -- also needed for clangd
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
