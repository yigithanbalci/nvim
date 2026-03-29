if _G.yeet.plugins.search == "telescope" then
  return {}
elseif _G.yeet.plugins.search == "fzf-lua" then
  return {
    -- TODO yigithanbalci 2026-03-29: Add multiline match for grep
    {
      "ibhagwan/fzf-lua",
      keys = {
        { "<leader><space>", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>gd", false }, -- Disable LazyVim's fzf-lua Git Diff so diffview.nvim owns <leader>gd
        { "<leader>gD", false }, -- Disable LazyVim's fzf-lua Git Diff so diffview.nvim owns <leader>gD
      },
    },
  }
else
  return {}
end
