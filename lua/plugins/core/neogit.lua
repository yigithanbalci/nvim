if not _G.yeet.plugins.git.neogit.enabled then
  return {}
end
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  cmd = "Neogit",
  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open({ cwd = LazyVim.root.git() })
      end,
      desc = "Neogit (Root Dir)",
    },
    {
      "<leader>gG",
      function()
        require("neogit").open()
      end,
      desc = "Neogit (cwd)",
    },
  },
  opts = {
    integrations = {
      diffview = true,
    },
  },
}
