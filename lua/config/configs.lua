-- lua/config/configs.lua
local M = {}

-- Enable Language Plugins that might not be used at all for some configuration (e.g. work)
vim.g.my_config = {
  -- The picker is either fzf-lua or telescope
  search = "fzf-lua",
  codings = {
    blink = {
      enabled = true,
    },
    luasnip = {
      enabled = true,
    },
  },
  langs = {
    clangd = {
      enabled = false,
    },
    cmake = {
      enabled = false,
    },
    go = {
      enabled = false,
    },
    flutter = {
      enabled = false,
      config = "flutter-tools",
    },
    java = {
      enabled = false,
    },
    json = {
      enabled = true,
    },
    markdown = {
      enabled = true,
    },
    ocaml = {
      enabled = false,
    },
    python = {
      enabled = true,
      lsp = "pyright",
      ruff = "ruff",
    },
    rust = {
      enabled = false,
      diagnostics = "rust-analyzer",
    },
    sql = {
      enabled = true,
    },
    toml = {
      enabled = true,
    },
    typescript = {
      enabled = true,
    },
    zig = {
      enabled = false,
    },
  },
  linters = {
    eslint = {
      enabled = true,
    },
  },
  formatters = {
    prettier = {
      enabled = true,
    },
  },
  ai = {
    avante = {
      enabled = false,
    },
    copilot = {
      enabled = true,
    },
  },
  extras = {
    leetcode = false,
  },
}

function M.get_lazy_spec()
  local cfg = vim.g.my_config

  local spec = {
    -- Core LazyVim + utilities
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.test.core" },
    { import = "lazyvim.plugins.extras.editor.mini-files" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
  }

  local lang_map = {
    clangd = "lazyvim.plugins.extras.lang.clangd",
    cmake = "lazyvim.plugins.extras.lang.cmake",
    go = "lazyvim.plugins.extras.lang.go",
    java = "lazyvim.plugins.extras.lang.java",
    json = "lazyvim.plugins.extras.lang.json",
    markdown = "lazyvim.plugins.extras.lang.markdown",
    ocaml = "lazyvim.plugins.extras.lang.ocaml",
    python = "lazyvim.plugins.extras.lang.python",
    rust = "lazyvim.plugins.extras.lang.rust",
    sql = "lazyvim.plugins.extras.lang.sql",
    toml = "lazyvim.plugins.extras.lang.toml",
    typescript = "lazyvim.plugins.extras.lang.typescript",
    zig = "lazyvim.plugins.extras.lang.zig",
  }

  for lang, info in pairs(cfg.langs or {}) do
    if info.enabled and lang_map[lang] then
      table.insert(spec, { import = lang_map[lang] })
    end
  end

  local coding_map = {
    blink = "lazyvim.plugins.extras.coding.blink",
    luasnip = "lazyvim.plugins.extras.coding.luasnip",
  }

  for coding, info in pairs(cfg.codings or {}) do
    if info.enabled and coding_map[coding] then
      table.insert(spec, { import = coding_map[coding] })
    end
  end

  local linter_map = {
    eslint = "lazyvim.plugins.extras.linting.eslint",
  }

  for linter, info in pairs(cfg.linters or {}) do
    if info.enabled and linter_map[linter] then
      table.insert(spec, { import = linter_map[linter] })
    end
  end

  local formatter_map = {
    prettier = "lazyvim.plugins.extras.formatting.prettier",
  }

  for formatter, info in pairs(cfg.formatters or {}) do
    if info.enabled and formatter_map[formatter] then
      table.insert(spec, { import = formatter_map[formatter] })
    end
  end

  local ai_map = {
    copilot = "lazyvim.plugins.extras.ai.copilot",
    avante = "lazyvim.plugins.extras.ai.avante",
  }

  for ai, info in pairs(cfg.ai or {}) do
    if info.enabled and ai_map[ai] then
      table.insert(spec, { import = ai_map[ai] })
    end
  end

  vim.list_extend(spec, {
    { import = "plugins/core" },
    { import = "plugins/extras" },
    { import = "plugins/lang" },
    { import = "plugins/ui" },
    { import = "plugins/util" },
  })

  return spec
end

return M
