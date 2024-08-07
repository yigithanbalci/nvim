return {
  "akinsho/bufferline.nvim",
  keys = {
    --TODO: false didn't work here
    { "<S-h>", '<Cmd>execute "normal! H"<CR>', { desc = "Make default H movement" } },
    { "<S-l>", '<Cmd>execute "normal! L"<CR>', { desc = "Make default H movement" } },
    { "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer (default no bufferline)" } },
    { "]b", "<cmd>bnext<cr>", { desc = "Next buffer (default no bufferline)" } },
  },
}
