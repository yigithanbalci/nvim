--NOTE: Flutter is not supported by LazuVim directly for now
if not vim.g.my_config.langs.flutter.enabled then
  return {}
elseif vim.g.my_config.langs.flutter.config == "flutter-tools" then
  return {
    {
      "nvim-flutter/flutter-tools.nvim",
      lazy = false,
      dependencies = {
        "nvim-lua/plenary.nvim",
        "stevearc/dressing.nvim", -- optional for vim.ui.select
      },
      opts = {
        settings = {
          enableSnippet = true,
        },
      },
    },
  }
end
return {}
