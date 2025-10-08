if not vim.g.my_config.langs.typescript.enabled then
  return {}
end
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "jsdoc",
        "tsx",
        "typescript",
      },
    },
  },
  {
    --NOTE: double tap diagnostic hover (K) to enter the opened popup
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = "auto" },
          },
        },
      },
      setup = {
        eslint = function()
          local function get_client(buf)
            local clients = vim.lsp.get_clients({ name = "eslint", bufnr = buf })
            return clients[1]
          end

          local formatter = LazyVim.lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })
          -- Add Eslint and use it for formatting
          -- https://www.lazyvim.org/configuration/recipes#add-eslint-and-use-it-for-formatting
          -- require("lazyvim.util").lsp.on_attach(function(client)
          --   if client.name == "eslint" then
          --     client.server_capabilities.documentFormattingProvider = true
          --   elseif client.name == "tsserver" then
          --     client.server_capabilities.documentFormattingProvider = false
          --   end
          -- end)

          -- Use EslintFixAll on Neovim < 0.10.0
          if not pcall(require, "vim.lsp._dynamic") then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end
            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          -- register the formatter with LazyVim
          LazyVim.format.register(formatter)
        end,
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = {
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "npm test --detectOpenHandles",
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
