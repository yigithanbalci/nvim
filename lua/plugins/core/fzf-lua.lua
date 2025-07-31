if vim.g.my_config.search == "telescope" then
  return {}
elseif vim.g.my_config.search == "fzf-lua" then
  return {
    --NOTE: I am using default setting of lazyvim except a couple of keybindings
    {
      "ibhagwan/fzf-lua",
      keys = {
        { "<leader><space>", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      },
    },
  }
else
  return {}
end
