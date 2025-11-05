if not vim.g.my_config.extras.sonarlint then
  return {}
end
return {
  {
    "mason-org/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "sonarlint-language-server",
      },
    },
  },
  -- TODO yigithanbalciacc 2025-11-05: add sonarlint.nvim later
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sonarlint = {
          cmd = { "sonarlint-language-server", "-stdio" },
          filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
          root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
          settings = {
            sonarlint = {
              rules = {
                -- Example: disable a rule
                ["typescript:S125"] = { level = "off" }, -- remove commented-out code rule
              },
            },
          },
        },
      },
    },
  },
}
