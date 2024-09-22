return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        go = { "goimports", "gofmt" },
        typescript = { "prettier" },
        ocaml = { "ocamlformat " },
        markdown = { "prettier", "markdown-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdown-cli2", "markdown-toc" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        fish = { "fish" },
        go = { "golangcilint" },
        typescript = { "eslint" },
      },
      linters = {},
    },
  },
}
