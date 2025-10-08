--TODO: does this need update?
-- keep track of current mode for DAP-UI
local minimal_mode = false
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "diff",
        "html",
        "json",
        "jsonc",
        "query",
        "regex",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "taplo",
      },
    },
  },
  {
    --NOTE: double tap diagnostic hover (K) to enter the opened popup
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        --TODO yigithanbalci 14-05-2025: fix dependency on taplo.toml in project root
        -- make formatter options work with .config dir or pass through lspconfig
        taplo = {
          filetypes = { "toml" },
          root_dir = function(path)
            return vim.fs.root(path, { "*.toml", ".git" })
          end,
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" } })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = {
      -- format_on_save = {
      --   -- These options will be passed to conform.format()
      --   timeout_ms = 500,
      --   lsp_format = "fallback",
      -- },
      formatters_by_ft = {
        fish = { "fish_indent" },
        sh = { "shfmt" },
        toml = { "taplo" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        fish = { "fish" },
      },
      linters = {},
    },
  },
  {
    "nvim-neotest/neotest",
    keys = {
      { "<leader>t", "", desc = "+test" },
      {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run File",
      },
      {
        "<leader>tT",
        function()
          require("neotest").run.run(vim.uv.cwd())
        end,
        desc = "Run All Test Files",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Show Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop",
      },
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Toggle Watch",
      },
    },
  },
}
