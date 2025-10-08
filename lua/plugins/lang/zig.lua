if not vim.g.my_config.langs.zig.enabled then
  return {}
end
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "zls",
      },
    },
  },
}
