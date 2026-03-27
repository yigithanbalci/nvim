-- TODO yigithanbalci 2026-03-27: Search those two issues if fixable:
-- when :q only open buffer except dap-ui, does not exit from nvim
-- when do dap-ui switch mode opens dap-ui because of close-open structure
local is_minimal = _G.yeet.plugins.dap.is_minimal
local default_layouts = nil
local saved_element_buffers = nil

local minimal_layouts = {
  {
    elements = {
      { id = "scopes", size = 1.0 },
    },
    size = 12,
    position = "bottom",
  },
}

-- Switch layouts without calling dapui.setup() (which destroys element buffers
-- and kills the debug session). Instead, update config and rebuild windows directly.
local function switch_layouts(layouts)
  local dapui = require("dapui")
  dapui.close()
  require("dapui.config").setup({ layouts = layouts })
  require("dapui.windows").setup(saved_element_buffers)
  dapui.open({ reset = true })
end

return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        keys = {
          {
            "<leader>du",
            function()
              require("dapui").toggle({ reset = true })
            end,
            desc = "Dap UI",
          },
          {
            "<leader>dT",
            function()
              is_minimal = not is_minimal
              switch_layouts(is_minimal and minimal_layouts or default_layouts)
            end,
            desc = "Toggle DAP UI minimal/default",
          },
          {
            "<leader>de",
            function()
              require("dapui").eval(nil, { enter = true })
            end,
            desc = "Eval",
            mode = { "n", "v" },
          },
        },
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          local dapui_windows = require("dapui.windows")

          -- Intercept windows.setup to capture element_buffers (not exposed by dapui)
          local original_windows_setup = dapui_windows.setup
          dapui_windows.setup = function(element_buffers)
            saved_element_buffers = element_buffers
            return original_windows_setup(element_buffers)
          end

          dapui.setup(opts)
          dapui_windows.setup = original_windows_setup

          -- Capture default layouts after LazyVim's setup
          default_layouts = vim.deepcopy(require("dapui.config").layouts)

          -- Apply minimal layout on startup if configured
          if is_minimal then
            require("dapui.config").setup({ layouts = minimal_layouts })
            dapui_windows.setup(saved_element_buffers)
          end

          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end

          vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("DapReplWrap", { clear = true }),
            pattern = "*dap-repl*",
            callback = function()
              vim.wo.wrap = true
            end,
          })
        end,
      },
    },
    -- stylua: ignore
    keys = {
      { "<F1>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F2>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F3>", function() require("dap").step_out() end, desc = "Step Out" },
      { "<F4>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<F5>", function() require("dap").continue() end, desc = "Continue" },
    },
  },
}

