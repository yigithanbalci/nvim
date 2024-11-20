local Util = require("lazyvim.util")
return {
  { "folke/snacks.nvim", opts = { dashboard = { enabled = false } } },
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
    -- NOTE: Rewrite default dashbaord (instead of alpha) to add auto-session lens as action
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
      "rmagatti/auto-session",
      "nvim-tree/nvim-web-devicons",
    },
    opts = function(_, opts)
      opts.config.center = {
        {
          action = "lua LazyVim.pick()()",
          desc = " Find File",
          icon = " ",
          key = "f",
        },
        {
          action = "ene | startinsert",
          desc = " New File",
          icon = " ",
          key = "n",
        },
        {
          action = 'lua LazyVim.pick("oldfiles")()',
          desc = " Recent Files",
          icon = " ",
          key = "r",
        },
        {
          action = 'lua LazyVim.pick("live_grep")()',
          desc = " Find Text",
          icon = " ",
          key = "g",
        },
        {
          action = "lua LazyVim.pick.config_files()()",
          desc = " Config",
          icon = " ",
          key = "c",
        },
        {
          action = 'lua require("persistence").load()',
          desc = " Restore Session",
          icon = " ",
          key = "s",
        },
        {
          action = 'lua require("auto-session.session-lens").search_session()',
          desc = " Search Prev Sessions",
          icon = " ",
          key = "S",
        },
        {
          action = "LazyExtras",
          desc = " Lazy Extras",
          icon = " ",
          key = "x",
        },
        {
          action = "Lazy",
          desc = " Lazy",
          icon = "󰒲 ",
          key = "l",
        },
        {
          action = function()
            vim.api.nvim_input("<cmd>qa<cr>")
          end,
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }
      return opts
    end,
  },
}
