-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- TypeScript - Auto-import, remove unused imports, and organize on save (before formatting)
-- Uses buf_request_sync so each action completes before the next one starts
-- and before BufWritePre returns (which triggers formatting)
local function ts_lsp_action_sync(action, timeout)
  timeout = timeout or 3000
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "vtsls" })
  if #clients == 0 then
    clients = vim.lsp.get_clients({ bufnr = bufnr, name = "ts_ls" })
  end
  if #clients == 0 then
    return
  end

  local params = vim.lsp.util.make_range_params(0, clients[1].offset_encoding)
  params.context = {
    only = { action },
    diagnostics = {},
  }

  local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, timeout)
  if not results then
    return
  end

  for _, res in pairs(results) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, clients[1].offset_encoding)
      elseif r.command then
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("ts_imports", { clear = true }),
  pattern = { "*.tsx", "*.ts" },
  callback = function()
    ts_lsp_action_sync("source.addMissingImports.ts")
    ts_lsp_action_sync("source.removeUnusedImports.ts")
    ts_lsp_action_sync("source.organizeImports.ts")
  end,
})
