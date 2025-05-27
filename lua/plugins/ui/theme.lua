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

return {
  {
    "zaldih/themery.nvim",
    lazy = false,
    opts = {
      themes = {
        {
          name = "Day",
          colorscheme = "kanagawa-lotus",
        },
        {
          name = "Night",
          colorscheme = "kanagawa-dragon",
        },
      },
    },
    keys = {
      {
        "<leader>uu",
        ":Themery<CR>",
        desc = "Theme Pick",
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
      -- vim.o.background = vim.g.my_config.theme.scheme.background == "light" or "dark"
      -- vim.g.gruvbox_material_enable_italic = 1
      -- vim.g.gruvbox_material_enable_bold = 1
      -- vim.g.gruvbox_material_background = "hard"
      -- vim.g.gruvbox_material_foreground = "original"
      -- vim.g.gruvbox_material_ui_contrast = "high"
      -- vim.g.gruvbox_material_diagnostic_line_highlight = 1
      -- vim.g.gruvbox_material_diagnostic_text_highlight = 1
      --
      -- vim.g.gruvbox_material_better_performance = 1

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
          -- if (vim.g.colors_name or ""):find("catppuccin") then
          --   opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
          -- end
          --
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
    opts = {},
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
