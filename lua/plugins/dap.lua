return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
  -- stylua: ignore
  keys = {
    { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
    { "<leader>de", function() require("dapui").eval(nil, {enter = true}) end, desc = "Eval", mode = {"n", "v"} },
  },
      opts = {},
    },
    "leoluz/nvim-dap-go",
  },
  opts = function(_, opts)
    local dap = require("dap")
    -- Clangd
    if not dap.adapters["codelldb"] then
      require("dap").adapters["codelldb"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = {
            "--port",
            "${port}",
          },
        },
      }
    end
    for _, lang in ipairs({ "c", "cpp" }) do
      dap.configurations[lang] = {
        {
          type = "codelldb",
          request = "launch",
          name = "Launch file",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
        {
          type = "codelldb",
          request = "attach",
          name = "Attach to process",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end
    -------------------------------------
    -- Typescript
    if not dap.adapters["pwa-node"] then
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            LazyVim.get_pkg_path("js-debug-adapter", "/js-debug/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
    end

    if not dap.adapters["node"] then
      dap.adapters["node"] = function(cb, config)
        if config.type == "node" then
          config.type = "pwa-node"
        end
        local nativeAdapter = dap.adapters["pwa-node"]
        if type(nativeAdapter) == "function" then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    local vscode = require("dap.ext.vscode")
    vscode.type_to_filetypes["node"] = js_filetypes
    vscode.type_to_filetypes["pwa-node"] = js_filetypes

    for _, language in ipairs(js_filetypes) do
      --if not dap.configurations[language] then
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
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
          -- trace = true, -- include debugger info
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
      --end
    end
    -----------------------------------
    return opts
  end,
  keys = {
    {
      "<F1>",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<F2>",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<F3>",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
    {
      "<F4>",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to Cursor",
    },
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
  },
}
