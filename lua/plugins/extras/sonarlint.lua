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
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      require("sonarlint").setup({
        server = {
          cmd = {
            "sonarlint-language-server",
            "-stdio",
            "-analyzers",
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
          sonarlint = {
            rules = {
              ["typescript:S125"] = { level = "off" },
            },
          },
        },
      })
    end,
  },
}
