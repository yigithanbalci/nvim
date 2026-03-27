-- lua/plugins/spec.lua
local M = {}

-- Local mapping table to store specs by category
local MAPS = {
  ai = {
    claude_code = "lazyvim.plugins.extras.ai.claudecode",
    copilot = "lazyvim.plugins.extras.ai.copilot",
    avante = "lazyvim.plugins.extras.ai.avante",
  },
  coding = {
    blink = "lazyvim.plugins.extras.coding.blink",
    luasnip = "lazyvim.plugins.extras.coding.luasnip",
    mini_surround = "lazyvim.plugins.extras.coding.mini-surround",
  },
  editor = {
    mini_files = "lazyvim.plugins.extras.editor.mini-files",
  },
  -- No extras here bcz it is only used by my configs
  formatters = {
    prettier = "lazyvim.plugins.extras.formatting.prettier",
  },
  -- No Git mapping bcz lazy has gitsigns default
  -- and rest of them does not exist on lazyvim
  -- I manage them
  langs = {
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
  },
  linters = {
    eslint = "lazyvim.plugins.extras.linting.eslint",
  },
}

local function collect_extras(spec, user_category_cfg, mapping)
  if not user_category_cfg then
    return
  end
  for key, info in pairs(user_category_cfg) do
    if info.enabled and mapping[key] then
      table.insert(spec, { import = mapping[key] })
    end
  end
end

function M.get_lazy_spec()
  -- Fetch from the global table instead of vim.g
  -- That will be loaded to globals by that file
  local cfg = require("plugins.config")

  local spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.test.core" },
  }

  -- Iterate through our MAPS categories
  for category, mapping in pairs(MAPS) do
    collect_extras(spec, cfg[category], mapping)
  end

  -- Final static imports
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
