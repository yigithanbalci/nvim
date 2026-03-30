if not _G.yeet.plugins.editor.mini_files.enabled then
  return {}
end
-- Mini-files file manager
return {
  {
    "nvim-mini/mini.files",
    init = function()
      vim.api.nvim_create_user_command("MiniFiles", function(o)
        local arg = o.args ~= "" and o.args or nil
        local path
        if arg == "cwd" then
          path = vim.uv.cwd()
        elseif arg == "root" then
          path = LazyVim.root()
        else
          path = vim.api.nvim_buf_get_name(0)
        end
        require("mini.files").open(path, true)
      end, {
        nargs = "?",
        complete = function()
          return { "cwd", "root" }
        end,
      })
    end,
    opts = {
      file = {
        [".go-version"] = { glyph = "", hl = "MiniIconsBlue" },
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
        ["package.json"] = { glyph = "", hl = "MiniIconsYellow" },
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
      },
      filetype = {
        gotmpl = { glyph = "󰟓", hl = "MiniIconsGrey" },
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
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
    },
    keys = {
      {
        "<leader>fM",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>fm",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
  },
}
