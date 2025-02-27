return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- Set these options to hide bufferline
        mode = "tabs", -- This disables tabline, you can also use "tabs" to show tab pages
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
    keys = {
      --TODO: false didn't work here
      { "<S-h>", '<Cmd>execute "normal! H"<CR>', { desc = "Make default H movement" } },
      { "<S-l>", '<Cmd>execute "normal! L"<CR>', { desc = "Make default H movement" } },
      { "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer (default no bufferline)" } },
      { "]b", "<cmd>bnext<cr>", { desc = "Next buffer (default no bufferline)" } },
    },
  },
}
