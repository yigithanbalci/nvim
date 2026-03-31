if not _G.yeet.plugins.ai.claude_code.enabled then
  return {}
end
return {
  {
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
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>aC", "", desc = "+ClaudeCode", mode = { "n", "v" } },
      { "<leader>aCf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>aCr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aCC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>aCb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>aCs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>aCs",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil" },
      },
      -- Diff management
      { "<leader>aCa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>aCd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
