-- lua/plugins/config.lua
local cfg = {
  ai = {
    avante = { enabled = false },
    claude_code = { enabled = true },
    copilot = { enabled = false },
    copilot_chat = { enabled = false },
    --NOTE: copilot-native works better with sidekick I assume
    copilot_native = { enabled = true },
    sidekick = { enabled = true },
    _99 = { enabled = false },
  },
  coding = {
    blink = { enabled = true },
    luasnip = { enabled = true },
    mini_surround = { enabled = true },
    neogen = { enabled = true },
  },
  dap = {
    is_minimal = true,
  },
  editor = {
    -- Default file explorer for <leader>fe / <leader>fE
    -- Options: "snacks" | "neo-tree" | "mini_files" | "oil"
    file_explorer = "oil",
    -- NOTE: neo-tree is enabled by LazyVim default, this flag controls custom overrides
    neo_tree = { enabled = true },
    mini_files = { enabled = true },
    oil = { enabled = true },
  },
  extras = { leetcode = { enabled = true }, sonarlint = { enabled = true } },
  formatters = { prettier = { enabled = true } },
  git = {
    diffview = { enabled = true },
    -- GitSigns is enabled and managed by LazyVim
    -- but since event is LazyFile its shortcuts does not show on unmofied files
    gitsigns = { enabled = true },
    fugitive = { enabled = false },
    neogit = { enabled = true },
  },
  langs = {
    clangd = { enabled = true },
    cmake = { enabled = true },
    go = { enabled = true },
    flutter = { enabled = true, config = "flutter-tools" },
    java = { enabled = true },
    json = { enabled = true },
    markdown = { enabled = true },
    ocaml = { enabled = false },
    python = { enabled = true, lsp = "pyright", ruff = "ruff" },
    rust = { enabled = true, diagnostics = "rust-analyzer" },
    sql = { enabled = true },
    toml = { enabled = true },
    typescript = { enabled = true },
    zig = { enabled = true },
  },
  linters = { eslint = { enabled = true } },
}

-- Inject into your global namespace
_G.yeet = _G.yeet or {}
_G.yeet.plugins = cfg

return cfg
