# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim-based Neovim configuration, maintained as a git submodule of a larger dotfiles repo. It gets symlinked to `~/.config/nvim/` via GNU Stow.

## Formatting

Lua files are formatted with StyLua:

```bash
stylua .          # format all Lua files
stylua --check .  # check without modifying
```

Config: `stylua.toml` — 2-space indentation, 120 column width.

## Architecture

### Entry point and config loading

`init.lua` → `lua/config/lazy.lua` → `lua/config/configs.lua`

The key architectural pattern is the **centralized feature-flag system** in `lua/config/configs.lua`. The `vim.g.my_config` table controls which languages, AI tools, linters, formatters, and extras are enabled. The `get_lazy_spec()` function reads these flags and dynamically builds the lazy.nvim plugin spec by mapping enabled features to their corresponding LazyVim extras. This means you toggle language support or tools by flipping booleans in `configs.lua`, not by adding/removing import statements.

### Config files (`lua/config/`)

- `configs.lua` — Feature flags and dynamic spec builder (described above)
- `options.lua` — Vim options (leader = space, localleader = backslash, clipboard deliberately NOT synced with system)
- `keymaps.lua` — Custom keymaps layered on top of LazyVim defaults
- `autocmds.lua` — Custom autocommands (e.g., TypeScript auto-import on save)

### Plugin organization (`lua/plugins/`)

Plugins are organized into subdirectories, all imported by `get_lazy_spec()`:

- `core/` — Core editor plugins (snacks, which-key, fzf-lua, dap, fugitive)
- `lang/` — Language-specific overrides (go, java, typescript, flutter, ocaml, miscellaneous)
- `ui/` — Visual plugins (theme, lualine, bufferline, file manager, twilight)
- `util/` — Utility plugins (harpoon, undotree, copilot, avante, blink-cmp, mini, neogen, hardtime)
- `extras/` — Optional extras (leetcode, sonarlint, qfedit)

Each file in these directories returns a Lua table (or list of tables) following the lazy.nvim plugin spec format. These override or extend the base LazyVim plugin configurations.

### Snippets

Custom snippets live in `snippets/` (JSON format — `flutter.json`, `package.json`).

## Key conventions

- The picker is fzf-lua (set in `configs.lua`, not telescope)
- Completion engine is blink.cmp (not nvim-cmp)
- System clipboard is intentionally separated — use `cy`/`cp` keymaps for clipboard yank/paste
- VSCode compatibility: `init.lua` sets `vim.g.vscode = true` when running inside VSCode
