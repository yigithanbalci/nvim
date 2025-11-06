if not vim.g.my_config.langs.typescript.enabled then
  return {}
end
return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          JestConfigFile = "custom.jest.config.ts",
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function(_, opts)
      local dap = require("dap")
      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
      local new_configs = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug",
          args = { "${workspaceFolder}/src/main.ts" },
          runtimeArgs = { "--nolazy", "-r", "ts-node/register", "-r", "tsconfig-paths/register" },
          sourceMaps = true,
          cwd = "${workspaceFolder}",
          protocol = "inspector",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Launch",
          console = "integratedTerminal",
          outDir = "${workspaceFolder}/dist/**.js",
          program = "${workspaceFolder}/src/main.ts",
          args = { "${workspaceFolder}/src/main.ts" },
          runtimeArgs = { "--nolazy", "-r", "ts-node/register", "-r", "tsconfig-paths/register" },
          sourceMaps = true,
          cwd = "${workspaceFolder}",
          protocol = "auto",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
      }

      for _, language in ipairs(js_filetypes) do
        dap.configurations[language] = dap.configurations[language] or {}

        -- prevent duplicates by name
        local existing_names = {}
        for _, cfg in ipairs(dap.configurations[language]) do
          existing_names[cfg.name] = true
        end

        for _, cfg in ipairs(new_configs) do
          if not existing_names[cfg.name] then
            table.insert(dap.configurations[language], cfg)
          end
        end
      end
      return opts
    end,
  },
}
