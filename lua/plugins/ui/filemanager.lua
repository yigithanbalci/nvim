return {
  {
    "nvim-mini/mini.files",
    opts = {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
      mappings = {
        close = "q",
        go_in = "l",
        go_in_plus = "L",
        go_out = "h",
        go_out_plus = "H",
        mark_goto = "'",
        mark_set = "m",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = false,
      },
    },
    keys = {
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
      -- { "<leader>E", "<leader>fm", desc = "Open mini.files (Directory of Current File)", remap = true },
      -- { "<leader>e", "<leader>fM", desc = "Open mini.files (cwd)", remap = true },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    opts = {
      window = {
        mappings = {
          ["l"] = { "open", nowait = true },
          ["L"] = "focus_preview",
          ["h"] = "close_node",
        },
      },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline", "neo-tree" },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "focus" })
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
          },
          never_show = {},
        },
      },
    },
  },
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
      })
    end,
    keys = {
      {
        "<leader>o",
        function()
          require("oil").toggle_float()
        end,
        desc = "Oil Toggle Float",
        remap = true,
      },
      {
        "<leader>O",
        function()
          require("oil").open()()
        end,
        desc = "Explorer Oil (cwd)",
        remap = true,
      },
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
