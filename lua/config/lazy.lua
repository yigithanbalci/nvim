--TODO: update dadbod ui settings, especially tree
--TODO: fix git-worktree plugin
--TODO: fix neotest debug for jest
--TODO: refactor dir & structure
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("config.configs")
-- Build spec dynamically based on vim.g.my_config
local function get_lazy_spec()
  local cfg = vim.g.my_config
  local spec = {
    -- Core LazyVim + utilities
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- fundamental plugins for testing and debugging
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.test.core" },
    -- utilities
    { import = "lazyvim.plugins.extras.editor.mini-files" },
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    -- Linting and formatting (TypeScript)
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
  }

  -- Define mapping between your config and LazyVim extras
  local lang_map = {
    clangd = "lazyvim.plugins.extras.lang.clangd",
    cmake = "lazyvim.plugins.extras.lang.cmake",
    go = "lazyvim.plugins.extras.lang.go",
    flutter = "lazyvim.plugins.extras.lang.flutter",
    java = "lazyvim.plugins.extras.lang.java",
    markdown = "lazyvim.plugins.extras.lang.markdown",
    ocaml = "lazyvim.plugins.extras.lang.ocaml",
    python = "lazyvim.plugins.extras.lang.python",
    rust = "lazyvim.plugins.extras.lang.rust",
    typescript = "lazyvim.plugins.extras.lang.typescript",
    zig = "lazyvim.plugins.extras.lang.zig",
  }

  -- Dynamically include enabled language extras
  for lang, info in pairs(cfg.langs or {}) do
    if info.enabled and lang_map[lang] then
      table.insert(spec, { import = lang_map[lang] })
    end
  end

  -- Dynamically include AI extras
  local ai_map = {
    copilot = "lazyvim.plugins.extras.ai.copilot",
    avante = "lazyvim.plugins.extras.ai.avante",
  }
  for ai, info in pairs(cfg.ai or {}) do
    if info.enabled and ai_map[ai] then
      table.insert(spec, { import = ai_map[ai] })
    end
  end

  -- Always include your own plugin dirs
  vim.list_extend(spec, {
    { import = "plugins/core" },
    { import = "plugins/extras" },
    { import = "plugins/lang" },
    { import = "plugins/ui" },
    { import = "plugins/util" },
  })

  return spec
end

require("lazy").setup({
  spec = get_lazy_spec(),
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
