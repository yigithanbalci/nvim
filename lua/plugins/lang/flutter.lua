--NOTE: Flutter is not supported by LazuVim directly for now
if not _G.yeet.plugins.langs.flutter.enabled then
  return {}
elseif _G.yeet.plugins.langs.flutter.config == "flutter-tools" then
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
