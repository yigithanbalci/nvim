if not vim.g.my_config.git.diffview then
  return {}
end
return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
    { "<leader>gfh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History (current)" },
    { "<leader>gfH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History (all)" },
  },
  opts = {
    keymaps = {
      view = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } } },
      file_panel = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } } },
      file_history_panel = { { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } } },
    },
    view = {
      default = {
        layout = "diff2_horizontal",
        winbar_info = true,
      },
      merge_tool = {
        layout = "diff3_horizontal",
      },
      file_history = {
        layout = "diff2_horizontal",
      },
    },
    file_panel = {
      listing_style = "list",
      win_config = {
        position = "bottom",
        height = 10,
      },
    },
  },
}
