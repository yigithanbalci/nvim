return {
  "williamboman/mason.nvim",
  opts_extend = { "ensure_installed" },
  opts = {
    ensure_installed = {
      "js-debug-adapter",
      "ocamlearlybird",
      -- Rust Tools
      "codelldb", -- also needed for clangd
    },
  },
}
