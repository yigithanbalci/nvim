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

`init.lua` → `lua/config/lazy.lua` → `lua/plugins/spec.lua` + `lua/plugins/config.lua`

The key architectural pattern is the **centralized feature-flag system** split across two files:

- `lua/plugins/config.lua` — Defines the `cfg` table with feature flags for AI tools, languages, formatters, linters, editor options, etc. Also exposes the config globally as `_G.yeet.plugins`.
- `lua/plugins/spec.lua` — Contains `get_lazy_spec()` which reads the config flags and dynamically builds the lazy.nvim plugin spec by mapping enabled features to their corresponding LazyVim extras via a `MAPS` lookup table.

You toggle language support or tools by flipping `{ enabled = true/false }` in `config.lua`, not by adding/removing import statements.

### Config files (`lua/config/`)

- `options.lua` — Vim options (leader = space, localleader = backslash, clipboard deliberately NOT synced with system). Also pins Node.js to the nvm default version and sets `_G.yeet.search` for the picker.
- `keymaps.lua` — Custom keymaps layered on top of LazyVim defaults. Includes configurable file explorer keymaps driven by `_G.yeet.plugins.editor.file_explorer`.
- `autocmds.lua` — Custom autocommands (TypeScript auto-import and organize-imports on save via vtsls/ts_ls)

### Plugin organization (`lua/plugins/`)

Plugins are organized into subdirectories, all imported by `get_lazy_spec()`:

- `ai/` — AI tools (avante, copilot, claude-code, 99)
- `coding/` — Completion and code generation (blink-cmp, neogen, mini-surround)
- `core/` — Core editor plugins (whichkey, neogit, fugitive, diffview)
- `dap/` — Debug adapter protocol configuration
- `editor/` — File navigation and editing (harpoon, fzf-lua, snacks_picker, neo-tree, mini-files, oil, flash)
- `lang/` — Language-specific overrides (go, java, typescript, flutter, ocaml, miscellaneous)
- `ui/` — Visual plugins (theme, lualine, bufferline, snacks_dashboard, twilight, secret)
- `util/` — Utility plugins (undotree, hardtime, lazydocker, todo-comments, csvview)
- `extras/` — Optional extras (leetcode, sonarlint, qfedit)

Each file in these directories returns a Lua table (or list of tables) following the lazy.nvim plugin spec format. These override or extend the base LazyVim plugin configurations.

### Snippets

Custom snippets live in `snippets/` (JSON format — `flutter.json`, `package.json`).

## Key conventions

- Picker and completion engine are set to `"auto"` in options.lua (resolved by LazyVim based on enabled extras); fzf-lua and blink.cmp are the enabled extras
- File explorer is configurable via `_G.yeet.plugins.editor.file_explorer` in `config.lua` (options: `"snacks"`, `"neo-tree"`, `"mini_files"`, `"oil"`)
- System clipboard is intentionally separated — use `cy`/`cp` keymaps for clipboard yank/paste
- VSCode compatibility: `init.lua` sets `vim.g.vscode = true` when running inside VSCode
- Global namespace `_G.yeet` is used to share config state across files
