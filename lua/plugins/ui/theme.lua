-- Sets colors to line numbers Above, Current and Below  in this order
function LineNumberColors()
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
  -- vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff966c", bold = true })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FB508F", bold = true })
end
-- Apply custom highlights every time a colorscheme is loaded
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    if vim.fn.has("termguicolors") == 1 then
      vim.opt.termguicolors = true
    end
    LineNumberColors()
  end,
})

-- Apply transparency to all themes not only one
_G.transparent_enabled = _G.transparent_enabled or false

function SetBGTransparent()
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
  vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })
end

_G.SetBGTransparentIfTransparentEnabled = function()
  if _G.transparent_enabled then
    SetBGTransparent()
  end
end

function ToggleTransparency()
  if _G.transparent_enabled then
    SetBGTransparent()
  else
    vim.cmd("colorscheme " .. vim.g.colors_name) -- reset to theme defaults
  end
  _G.transparent_enabled = not _G.transparent_enabled
end

return {
  {
    "zaldih/themery.nvim",
    lazy = false,
    opts = {
      globalAfter = [[ _G.SetBGTransparentIfTransparentEnabled() ]],
      themes = {
        -- Kanagawa
        { name = "Kanagawa Day", colorscheme = "kanagawa-lotus" },
        { name = "Kanagawa Night", colorscheme = "kanagawa-dragon" },
        { name = "Kanagawa Neon", colorscheme = "kanagawa-wave" },

        -- Nightfox
        { name = "Nightfox", colorscheme = "nightfox" },
        { name = "Dayfox", colorscheme = "dayfox" },
        { name = "Dawnfox", colorscheme = "dawnfox" },
        { name = "Duskfox", colorscheme = "duskfox" },
        { name = "Nordfox", colorscheme = "nordfox" },
        { name = "Terrafox", colorscheme = "terafox" },
        { name = "Carbonfox", colorscheme = "carbonfox" },

        -- Catppuccin
        { name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
        { name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
        { name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
        { name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },

        -- Gruvbox (material and classic)
        { name = "Gruvbox Material Soft", colorscheme = "gruvbox-material" }, -- set background via `vim.g`
        { name = "Gruvbox Material Medium", colorscheme = "gruvbox-material" },
        { name = "Gruvbox Material Hard", colorscheme = "gruvbox-material" },
        { name = "Gruvbox (ellisonleao)", colorscheme = "gruvbox" },

        -- TokyoNight
        { name = "TokyoNight Storm", colorscheme = "tokyonight-storm" },
        { name = "TokyoNight Night", colorscheme = "tokyonight-night" },
        { name = "TokyoNight Moon", colorscheme = "tokyonight-moon" },
        { name = "TokyoNight Day", colorscheme = "tokyonight-day" },

        -- Ayu
        { name = "Ayu Light", colorscheme = "ayu", after = [[vim.g.ayucolor="light"]] },
        { name = "Ayu Mirage", colorscheme = "ayu", after = [[vim.g.ayucolor="light"]] },
        { name = "Ayu Dark", colorscheme = "ayu", after = [[vim.g.ayucolor="dark"]] },
      },
    },
    themeConfig = {
      defaultTheme = "TokyoNight Storm",
    },
    keys = {
      {
        "<leader>uu",
        ":Themery<CR>",
        desc = "Theme Pick (Themery)",
      },
      {
        "<leader>ut",
        function()
          local themery = require("themery")
          local currentTheme = themery.getCurrentTheme()

          if not currentTheme then
            vim.notify("No theme to toggle transparency", vim.log.levels.ERROR)
            return
          end
          if _G.transparent_enabled then
            SetBGTransparent()
          end
          _G.transparent_enabled = not _G.transparent_enabled
          themery.setThemeByName(currentTheme.name)
          --TODO: fix inconsistent transparency when changing themes
          -- idk if setting by theme and compiling like below is better?
          -- if currentTheme.name:lower():find("catppuccin") then
          --   local ok, catppuccin = pcall(require, "catppuccin")
          --   if ok then
          --     -- Toggle transparent_background
          --     catppuccin.options.transparent_background = not catppuccin.options.transparent_background
          --     catppuccin.compile() -- Recompile with new settings
          --     themery.setThemeByName(currentTheme.name)
          --   end
          -- else
          --   if _G.transparent_enabled then
          --     SetBGTransparent()
          --   end
          --   _G.transparent_enabled = not _G.transparent_enabled
          --   themery.setThemeByName(currentTheme.name)
          -- end
        end,
        desc = "Toggle Transparent BG (Themery)",
      },
    },
  },
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    opts = {},
  },
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    opts = function(_, opts)
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      -- vim.g.gruvbox_material_background = "hard"
      -- vim.g.gruvbox_material_foreground = "original"
      -- vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_text_highlight = 1

      vim.g.gruvbox_material_better_performance = 1

      return opts
    end,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    specs = {
      {
        "akinsho/bufferline.nvim",
        optional = true,
        opts = function(_, opts)
          if (vim.g.colors_name or ""):find("catppuccin") then
            opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
          end

          return opts
        end,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {},
  },
  {
    "ayu-theme/ayu-vim",
    lazy = true,
    config = function(_, opts) end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {},
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = {},
  },
}
