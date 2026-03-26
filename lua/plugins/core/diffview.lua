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
