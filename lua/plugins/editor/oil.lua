if not _G.yeet.plugins.editor.oil.enabled then
  return {}
end
-- Oil file manager
return {
  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    init = function()
      vim.api.nvim_create_user_command("OilFloat", function()
        -- Triggers lazy-load via :Oil, then opens float
        vim.cmd("Oil --float")
      end, {})
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-k>"] = false,
        ["<C-j>"] = false,
        ["<BS>"] = { "actions.parent", mode = "n" },
        ["<M-h>"] = "actions.select_split",
        ["q"] = "actions.close",
      },
      win_options = {
        winbar = "%{v:lua.CustomOilBar()}",
      },
      view_options = {
        show_hidden = true,
      },
    },
    config = function(_, opts)
      CustomOilBar = function()
        local path = vim.fn.expand("%")
        path = path:gsub("oil://", "")
        return "  " .. vim.fn.fnamemodify(path, ":.")
      end
      require("oil").setup(opts)
    end,
    keys = {
      {
        "<leader>fo",
        function()
          require("oil").toggle_float()
        end,
        desc = "Oil Toggle Float",
        remap = true,
      },
      {
        "<leader>fO",
        function()
          require("oil").open()()
        end,
        desc = "Explorer Oil (cwd)",
        remap = true,
      },
    },
  },
}
