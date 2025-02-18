return {
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = vim.log.levels.ERROR,
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_session_use_git_branch = false,

        auto_session_enabled = false,
        auto_session_enable_last_session = false,

        session_lens = {
          buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      })

      vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
        noremap = true,
      })
    end,
  },
  {
    "snacks.nvim",
    dependencies = {
      "rmagatti/auto-session",
    },
    opts = {
      dashboard = {
        preset = {
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        sections = {
          { section = "header" },
          --TODO: Add pokemon colorscript later
          -- {
          --   pane = 2,
          --   section = "terminal",
          --   cmd = "colorscript -e square",
          --   height = 5,
          --   padding = 1,
          -- },
          {
            section = "keys",
            gap = 1,
            padding = 1,
            keys = {
              { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
              { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
              { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
              { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
              {
                icon = " ",
                key = "c",
                desc = "Config",
                action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
              },
              { icon = " ", key = "s", desc = "Restore Session", section = "session" },
              {
                action = 'lua require("auto-session.session-lens").search_session()',
                desc = " Search Prev Sessions",
                icon = " ",
                key = "S",
              },

              { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
          },
          {
            pane = 2,
            icon = " ",
            desc = "Browse Repo",
            padding = 1,
            key = "b",
            action = function()
              Snacks.gitbrowse()
            end,
          },
          function()
            local in_git = Snacks.git.get_root() ~= nil
            local cmds = {
              {
                title = "Notifications",
                cmd = "gh notify -s -a -n5", --NOTE: this is an extension to gh CLI tool
                action = function()
                  vim.ui.open("https://github.com/notifications")
                end,
                key = "n",
                icon = " ",
                height = 5,
                enabled = true,
              },
              {
                title = "Open Issues",
                cmd = "gh issue list -L 3",
                key = "i",
                action = function()
                  vim.fn.jobstart("gh issue list --web", { detach = true })
                end,
                icon = " ",
                height = 7,
              },
              {
                icon = " ",
                title = "Open PRs",
                cmd = "gh pr list -L 3",
                key = "P",
                action = function()
                  vim.fn.jobstart("gh pr list --web", { detach = true })
                end,
                height = 7,
              },
              {
                icon = " ",
                title = "Git Status",
                cmd = "git --no-pager diff --stat -B -M -C",
                height = 10,
              },
            }
            return vim.tbl_map(function(cmd)
              return vim.tbl_extend("force", {
                pane = 2,
                section = "terminal",
                enabled = in_git,
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
              }, cmd)
            end, cmds)
          end,
          { section = "startup" },
        },
      },
    },
  },
  -- {
  --   -- NOTE: Rewrite default dashbaord (instead of alpha) to add auto-session lens as action
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   dependencies = {
  --     "rmagatti/auto-session",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  --   opts = function(_, opts)
  --     opts.config.center = {
  --       {
  --         action = "lua LazyVim.pick()()",
  --         desc = " Find File",
  --         icon = " ",
  --         key = "f",
  --       },
  --       {
  --         action = "ene | startinsert",
  --         desc = " New File",
  --         icon = " ",
  --         key = "n",
  --       },
  --       {
  --         action = 'lua LazyVim.pick("oldfiles")()',
  --         desc = " Recent Files",
  --         icon = " ",
  --         key = "r",
  --       },
  --       {
  --         action = 'lua LazyVim.pick("live_grep")()',
  --         desc = " Find Text",
  --         icon = " ",
  --         key = "g",
  --       },
  --       {
  --         action = "lua LazyVim.pick.config_files()()",
  --         desc = " Config",
  --         icon = " ",
  --         key = "c",
  --       },
  --       {
  --         action = 'lua require("persistence").load()',
  --         desc = " Restore Session",
  --         icon = " ",
  --         key = "s",
  --       },
  --       {
  --         action = "LazyExtras",
  --         desc = " Lazy Extras",
  --         icon = " ",
  --         key = "x",
  --       },
  --       {
  --         action = "Lazy",
  --         desc = " Lazy",
  --         icon = "󰒲 ",
  --         key = "l",
  --       },
  --       {
  --         action = function()
  --           vim.api.nvim_input("<cmd>qa<cr>")
  --         end,
  --         desc = " Quit",
  --         icon = " ",
  --         key = "q",
  --       },
  --     }
  --     return opts
  --   end,
  -- },
}
