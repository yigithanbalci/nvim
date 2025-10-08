if not vim.g.my_config.langs.python.enabled then
  return {}
end
return {
  --NOTE yigithanbalci 08-10-2025: Is this really necessary?
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/nvim-nio" },
  },
}
