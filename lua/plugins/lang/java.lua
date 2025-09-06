--TODO: update this file for java projects
if not vim.g.my_config.langs.java.enabled then
  return {}
end
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "java" },
    },
  },
  {
    "nvim-java/nvim-java",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
  },
}
