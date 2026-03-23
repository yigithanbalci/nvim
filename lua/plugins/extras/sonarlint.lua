-- TODO yigithanbalciacc 2025-11-05: should we move it to ts?
-- since this config is for ts?
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
  -- TODO yigithanbalciacc 2025-11-05: inspect if there will be any
  -- improvement/fix for this config
  {
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = { "javascript", "typescript" },
    config = function()
      require("sonarlint").setup({
        server = {
          cmd = {
            "sonarlint-language-server",
            "-stdio",
            "-analyzers",
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
            vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
        },
        settings = {
          sonarlint = {},
        },
      })
    end,
  },
}
