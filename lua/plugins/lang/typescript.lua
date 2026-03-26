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

      -- Find the nearest package.json directory from the current file,
      -- so cwd resolves correctly in multi-module/monorepo projects.
      local function get_project_root()
        local buf_path = vim.fn.expand("%:p:h")
        local root = vim.fs.find("package.json", { path = buf_path, upward = true })[1]
        if root then
          return vim.fn.fnamemodify(root, ":h")
        end
        return vim.fn.getcwd()
      end

      local new_configs = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Current File",
          program = "${file}",
          runtimeArgs = { "--nolazy", "-r", "ts-node/register", "-r", "tsconfig-paths/register" },
          sourceMaps = true,
          cwd = get_project_root,
          console = "integratedTerminal",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Entry Point (src/main.ts)",
          program = function()
            local root = get_project_root()
            local default = root .. "/src/main.ts"
            return vim.fn.input("Entry point: ", default, "file")
          end,
          runtimeArgs = { "--nolazy", "-r", "ts-node/register", "-r", "tsconfig-paths/register" },
          sourceMaps = true,
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          outFiles = { "${workspaceFolder}/dist/**/*.js" },
          cwd = get_project_root,
          console = "integratedTerminal",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Process",
          processId = require("dap.utils").pick_process,
          sourceMaps = true,
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          cwd = get_project_root,
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
          rootPath = get_project_root,
          cwd = get_project_root,
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
