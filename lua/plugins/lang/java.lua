--TODO: update this file for java projects
if not vim.g.my_config.langs.java.enabled then
  return {}
end
-- This is the same as in lspconfig.configs.jdtls, but avoids
-- needing to require that when this module loads.
local java_filetypes = { "java" }

return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim" },
    ft = java_filetypes,
    opts = {
      settings = {
        java = {
          inlayHints = { parameterNames = { enabled = "all" } },
          configuration = {
            updateBuildConfiguration = "automatic",
            runtimes = {},
          },
          compile = {
            annotationProcessing = { enabled = true },
          },
        },
      },
    },
  },
  -- Using autocmd launch (default)
  -- Default uses jars from mason or ~/.vscode/extensions/vmware.vscode-spring-boot-x.x.x
  {
    "JavaHello/spring-boot.nvim",
    ft = { "java", "yaml", "jproperties" },
    dependencies = {
      "mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
      "ibhagwan/fzf-lua", -- optional, for UI features like symbol picking. Other pickers (e.g., telescope.nvim) can also be used.
    },
    opts = {},
  },
}
