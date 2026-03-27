if not _G.yeet.plugins.langs.go.enabled then
  return {}
end
return {
  {
    --NOTE: double tap diagnostic hover (K) to enter the opened popup
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = {
                fieldalignment = true,
              },
            },
          },
        },
      },
    },
  },
}
