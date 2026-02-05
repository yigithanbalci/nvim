-- TODO yigithanbalci 2025-11-26: minimal mode is buggy
-- fix some time
-- debugger evaluate expression is buggy
-- there might be some update missing or something below is
-- creating that bug
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

vim.api.nvim_create_augroup("DapGroup", { clear = true })

local function navigate(args)
  local buffer = args.buf

  local wid = nil
  local win_ids = vim.api.nvim_list_wins() -- Get all window IDs
  for _, win_id in ipairs(win_ids) do
    local win_bufnr = vim.api.nvim_win_get_buf(win_id)
    if win_bufnr == buffer then
      wid = win_id
    end
  end

  if wid == nil then
    return
  end

  vim.schedule(function()
    if vim.api.nvim_win_is_valid(wid) then
      vim.api.nvim_set_current_win(wid)
    end
  end)
end

local function create_nav_options(name)
  return {
    group = "DapGroup",
    pattern = string.format("*%s*", name),
    callback = navigate,
  }
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
              -- Ensure configs are initialized before toggling
              require("dapui").toggle({ reset = true })
            end,
            desc = "(Toggle)Dap UI",
          },
          {
            "<leader>dT",
            function()
              local dapui = require("dapui")
              -- Toggles between minimal and default by re-running setup
              -- Assuming minimal_mode/opts are defined in your scope or globals
              _G.minimal_mode = not _G.minimal_mode
              dapui.setup(_G.minimal_mode and _G.minimal_opts or _G.default_opts)
            end,
            desc = "(Toggle) DAP UI mininal/default",
          },
          {
            "<leader>de",
            function()
              require("dapui").eval(nil, { enter = true })
            end,
            desc = "Evaluate under cursor",
            mode = { "n", "v" },
          },
          {
            "<leader>dfb",
            function()
              require("dapui").float_element("breakpoints", { enter = true, width = 60, height = 20 })
            end,
            desc = "(Floating)Breakpoints",
          },
          {
            "<leader>dfs",
            function()
              require("dapui").float_element("stacks", { enter = true, width = 60, height = 20 })
            end,
            desc = "(Floating)Stacks",
          },
          {
            "<leader>dfr",
            function()
              require("dapui").float_element("repl", { enter = true, width = 80, height = 20 })
            end,
            desc = "(Floating)Repl",
          },
        },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")

          -- 1. Standard Setup (Replaces the buggy custom layout loop)
          dapui.setup({
            -- Add any specific options here if needed, otherwise defaults are used
          })

          -- 2. The Navigation Options from Block 2
          -- Note: Ensure `create_nav_options` is defined in your global scope or utils
          -- I added a check to prevent errors if the function is missing
          if type(create_nav_options) == "function" then
            -- Apply to REPL
            vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("dap-repl"))
            -- Apply to Watches
            vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("DAP Watches"))
            -- You might want to add others here (e.g., Stacks, Breakpoints)
            -- vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("DAP Stacks"))
          end

          -- 3. Console/Repl Wrapping
          vim.api.nvim_create_autocmd("BufEnter", {
            group = vim.api.nvim_create_augroup("DapGroup", { clear = true }),
            pattern = "*dap-repl*",
            callback = function()
              vim.wo.wrap = true
            end,
          })

          -- 4. Listeners (Auto-close UI when debug ends)
          dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
          end
          dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
          end

          -- 5. Send Console Output to DAP UI
          dap.listeners.after.event_output.dapui_config = function(_, body)
            if body.category == "console" then
              dapui.eval(body.output)
            end
          end
        end,
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
