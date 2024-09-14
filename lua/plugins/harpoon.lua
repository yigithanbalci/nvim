return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
  },
  keys = {
    { "<leader>h", "", desc = "+harpoon" },
    {
      "<leader>hm",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon file",
    },
    {
      "<leader>hh",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon quick menu",
    },
    {
      "<leader>h1",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon to file 1",
    },
    {
      "<leader>h2",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon to file 2",
    },
    {
      "<leader>h3",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon to file 3",
    },
  },
}
