local minimal_mode = true
local minimal_opts
local default_opts

-- deep copy helper that recreates nested tables explicitly
local function deepcopy_config(cfg)
  local copy = vim.deepcopy(cfg)

  -- Force independent layouts/elements table
  if copy.layouts then
    copy.layouts = vim.tbl_map(function(layout)
      local new_layout = vim.deepcopy(layout)
      if new_layout.elements then
        new_layout.elements = vim.tbl_map(vim.deepcopy, new_layout.elements)
      end
      return new_layout
    end, copy.layouts)
  end

  return copy
end

local function initialize_configs()
  if not default_opts then
    default_opts = deepcopy_config(require("dapui.config"))
    default_opts.floating.mappings.close = { "q", "<Esc>" }
  end
  if not minimal_opts then
    minimal_opts = deepcopy_config(require("dapui.config"))
    minimal_opts.expand_lines = true
    minimal_opts.controls.enabled = true
    minimal_opts.floating.border = "rounded"
    minimal_opts.render.max_type_length = 60
    minimal_opts.render.max_value_lines = 200
    minimal_opts.layouts = {
      {
        elements = {
          { id = "scopes", size = 1.0 }, -- 100% of this panel is scopes
        },
        size = 15, -- height in lines (adjust to taste)
        position = "bottom", -- "left", "right", "top", "bottom"
      },
    }
    -- initialize dapui with the chosen (minimal_mode) config
    local dapui = require("dapui")
    dapui.setup(minimal_mode and minimal_opts or default_opts)
  end
end

return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        keys = {
          {
            "<leader>du",
            function()
              initialize_configs()
              local dapui = require("dapui")
              dapui.toggle({ reset = true })
            end,
            desc = "(Toggle)Dap UI",
          },
          {
            "<leader>dT",
            function()
              minimal_mode = not minimal_mode
              initialize_configs()
              local dapui = require("dapui")
              dapui.setup(minimal_mode and minimal_opts or default_opts)
              --NOTE yigithanbalci 22-09-2025: toggle or open/clode does not work properly
              --maybe investigate later
            end,
            desc = "(Toggle) DAP UI mininal/default",
          },
          {
            "<leader>de",
            function()
              initialize_configs()
              require("dapui").eval(nil, { enter = true })
            end,
            desc = "Evaluate under cursor",
            mode = { "n", "v" },
          },
          {
            "<leader>dfb",
            function()
              initialize_configs()
              require("dapui").float_element("breakpoints", { enter = true, width = 60, height = 20 })
            end,
            desc = "(Floating)Breakpoints",
          },
          {
            "<leader>dfs",
            function()
              initialize_configs()
              require("dapui").float_element("stacks", { enter = true, width = 60, height = 20 })
            end,
            desc = "(Floating)Stacks",
          },
          {
            "<leader>dfr",
            function()
              initialize_configs()
              require("dapui").float_element("repl", { enter = true, width = 80, height = 20 })
            end,
            desc = "(Floating)Repl",
          },
        },
        opts = {},
      },
    },
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
  },
}
