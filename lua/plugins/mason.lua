return {
  "williamboman/mason.nvim",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      -- C/C++ Tools
      "cmakelang",
      "cmakelint",
      ----------------
      "js-debug-adapter",
      "ocamlearlybird",
      -- Rust Tools
      "codelldb", -- also needed for clangd
      -- "rust-analyzer",
      -- "rustfmt",
      ----------------
      -- Java Tools
      --"java-debug-adapter",
      --"java-test",
      --
      "markdownlint-cli2",
      "markdown-toc",
      -- Go Tools
      "goimports",
      "gofumpt",
      "gomodifytags",
      "impl",
      "delve",
      -----------
    },
  },
}
