if not vim.g.my_config.theme.enabled then
  return {}
end
-- Sets colors to line numbers Above, Current and Below  in this order
function LineNumberColors()
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = true })
  -- vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff966c", bold = true })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#FB508F", bold = true })
end
-- Sets theme
function SetTheme()
  if vim.fn.has("termguicolors") == 1 then
    vim.opt.termguicolors = true
  end
  if vim.g.my_config.theme.scheme then
    if vim.g.my_config.theme.scheme.name then
      if vim.g.my_config.theme.scheme.style and vim.g.my_config.theme.scheme.style ~= "" then
        vim.cmd("colorscheme " .. vim.g.my_config.theme.scheme.style)
      else
        vim.cmd("colorscheme " .. vim.g.my_config.theme.scheme.name)
      end
    end
  end
  -- NOTE: Line number colors can only override after setting theme
  -- This also seems like not overriding current line number color somehow
  LineNumberColors()
end

return {
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    opts = function(_, opts)
      SetTheme()
      return opts
    end,
  },
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    opts = function(_, opts)
      vim.o.background = vim.g.my_config.theme.scheme.background == "light" or "dark"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "original"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_text_highlight = 1

      vim.g.gruvbox_material_better_performance = 1

      SetTheme()
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

          SetTheme()
          return opts
        end,
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = function(_, opts)
      SetTheme()
      return opts
    end,
  },
  {
    "ayu-theme/ayu-vim",
    lazy = true,
    opts = function(_, opts)
      SetTheme()
      vim.g.ayucolor = vim.g.my_config.theme.scheme.background == "light" or "dark"
      return opts
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = function(_, opts)
      SetTheme()
      vim.o.background = vim.g.my_config.theme.scheme.background == "light" or "dark"
      return opts
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = function(_, opts)
      SetTheme()
      -- opts.theme = vim.g.my_config.theme.scheme.style or "wave"
      return opts
    end,
  },
}
