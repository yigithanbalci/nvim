return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      CustomOilBar = function()
        local path = vim.fn.expand("%")
        path = path:gsub("oil://", "")

        return "  " .. vim.fn.fnamemodify(path, ":.")
      end

      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
          ["<C-k>"] = false,
          ["<C-j>"] = false,
          ["<M-h>"] = "actions.select_split",
          ["q"] = "actions.close",
        },
        win_options = {
          winbar = "%{v:lua.CustomOilBar()}",
        },
        view_options = {
          show_hidden = true,
        },
      })
    end,
    keys = {
      { "<leader>e", ":Oil<CR>", desc = "Explorer Oil (cwd)", remap = true },
      { "<leader>o", "", desc = "Oil", remap = true },
      {
        "<leader>o-",
        function()
          require("oil").toggle_float()
        end,
        desc = "Open parent directory in Floating Window",
        remap = true,
      },
    },
  },
}
