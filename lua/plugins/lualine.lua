return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  -- TODO: This plugin+snacks+this config results error sometimes, fix it later
  opts = function(_, opts)
    -- Ensure to copy the default LazyVim lualine options to preserve them
    opts.options.globalstatus = true

    -- Save default sections and use them in winbar
    local default_sections = vim.deepcopy(opts.sections)

    -- Configure winbar using default sections
    opts.winbar = default_sections
    opts.inactive_winbar = default_sections

    -- Clear out the default sections to prevent double rendering at the bottom
    opts.sections = {}
    opts.inactive_sections = opts.sections
    return opts
  end,
}
