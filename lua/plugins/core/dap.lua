-- TODO yigithanbalci 2025-11-26: minimal mode was buggy
-- removed it completely for now
-- evaluate expression was giving false values

return {
  {
    "mfussenegger/nvim-dap",
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
