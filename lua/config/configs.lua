-- Enable Language Plugins that might not be used at all for some configuration (e.g. work)
vim.g.my_config = {
  -- The picker is either fzf-lua or telescope
  search = "fzf-lua",
  langs = {
    clangd = {
      enabled = true,
    },
    cmake = {
      enabled = true,
    },
    go = {
      enabled = true,
    },
    flutter = {
      enabled = true,
      config = "flutter-tools",
    },
    java = {
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
      enabled = true,
      diagnostics = "rust-analyzer",
    },
    typescript = {
      enabled = true,
    },
    zig = {
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
    leetcode = true,
  },
}
