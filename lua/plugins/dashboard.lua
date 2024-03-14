local Util = require("lazyvim.util")
return {
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = vim.log.levels.ERROR,
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_session_use_git_branch = false,

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
    },
    opts = function(_, opts)
      opts.config.center = {
        {
          action = Util.telescope("files"),
          desc = " Find file",
          icon = " ",
          key = "f",
        },
        {
          action = "ene | startinsert",
          desc = " New file",
          icon = " ",
          key = "n",
        },
        {
          action = "Telescope oldfiles",
          desc = " Recent files",
          icon = " ",
          key = "r",
        },
        {
          action = "Telescope live_grep",
          desc = " Find text",
          icon = " ",
          key = "g",
        },
        {
          action = [[lua require("lazyvim.util").telescope.config_files()()]],
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
          action = "qa",
          desc = " Quit",
          icon = " ",
          key = "q",
        },
      }
    end,
  },
}
