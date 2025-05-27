-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- TypeScript - Remove unused imports on save
-- --TODO yigithanbalci 13-03-2025: investigate wtf is happening with this for
-- removeUnusedImports & organizeImports
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("ts_imports", { clear = true }),
  pattern = { "*.tsx,*.ts" },
  callback = function()
    -- vim.lsp.buf.code_action({
    --   apply = true,
    --   context = {
    --     only = {
    --       "source.removeUnusedImports",
    --     },
    --     diagnostics = {},
    --   },
    -- })
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = {
          "source.addMissingImports.ts",
        },
        diagnostics = {},
      },
    })
    -- vim.lsp.buf.code_action({
    --   apply = true,
    --   context = {
    --     only = {
    --       "source.organizeImports",
    --     },
    --     diagnostics = {},
    --   },
    -- })
  end,
})

-- AutoFormat for Nvim 0.11+ & LazyVim 15+
-- For whatever reason it was not working
-- TODO: AutoSave is somewhat too slow compared to LazyVim version below 15
-- and old plugins, if it continues try to fix it...
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
