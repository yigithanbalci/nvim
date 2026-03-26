return {
  "coder/claudecode.nvim",
  opts = {
    diff_opts = {
      open_in_new_tab = true,
      hide_terminal_in_new_tab = true,
    },
  },
  init = function()
    -- When a diff opens in a new tab, toggle the claudecode terminal in the original tab
    -- so toggling it back is a single press instead of two.
    vim.api.nvim_create_autocmd("TabNewEntered", {
      callback = function()
        vim.schedule(function()
          local buf = vim.api.nvim_get_current_buf()
          if vim.b[buf].claudecode_diff_tab_name then
            local ok, terminal = pcall(require, "claudecode.terminal")
            if ok then
              terminal.toggle()()
            end
          end
        end)
      end,
    })
  end,
}
