-- Neotree file manager
-- Lazuvim has this as default
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fn",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fN",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
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
        --NOTE: position: left, right, top, bottom, float, current
        --current Open within the current window, like netrw or vinegar would.
        --left breaks other buffers, so, I made it float instead
        position = "float",
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
}
