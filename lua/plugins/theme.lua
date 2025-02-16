return {
  --{ "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = {
  --  flavour = "macchiato",
  --} },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   name = "nightfox",
  --   opts = function(_, opts)
  --     if vim.fn.has("termguicolors") == 1 then
  --       vim.opt.termguicolors = true
  --     end
  --     vim.cmd([[colorscheme nightfox]])
  --     return opts
  --   end,
  -- },
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    opts = function(_, opts)
      if vim.fn.has("termguicolors") == 1 then
        vim.opt.termguicolors = true
      end
      vim.opt.background = "dark"
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_foreground = "original"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_text_highlight = 1

      vim.g.gruvbox_material_better_performance = 1

      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
}
