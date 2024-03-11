return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      svelte = { 'prettier' },
      css = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      graphql = { 'prettier' },
      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black' },
      go = { 'goimports', 'gofmt' },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
  },
}, {
  'mfussenegger/nvim-lint',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      python = { 'pylint' },
      go = { 'golangcilint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
