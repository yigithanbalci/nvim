if not vim.g.my_config.langs.go.enabled then
  return {}
end
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
    },
  },
}
