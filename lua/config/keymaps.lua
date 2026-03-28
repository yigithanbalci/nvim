-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
--NOTE: Below mappings are custom not from lazyvim ---------------------------------------------

-- better tricks navigation etc
map("x", "<leader>p", '"_dP', { desc = "Paste without replacing the register with deleted" })
map("n", "<C-u>", "<C-u>zz", { desc = "Navigate up half a page and center page" })
map("n", "<C-d>", "<C-d>zz", { desc = "Navigate down half a page and center page" })
map("n", "n", "nzzzv", { desc = "Navigate next and center the page" })
map("n", "N", "Nzzzv", { desc = "Navigate previous and center the page" })
--map("n", "<S-h>", '<Cmd>execute "normal! H"<CR>', { desc = "Make default H movement"})
--map("n", "<S-l>", '<Cmd>execute "normal! L"<CR>', { desc = "Make default H movement"})
map("i", "jj", "<esc>")
-- map("i", "jk", "<esc>")
-- map("i", "kk", "<esc>")
-- map("i", "kj", "<esc>")

-- keys to move selection up and down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection downwards" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection upwards" })

-- NOTE: c-o and c-i are forward and backward that is so nice in other IDEs
-- below is to yank and paste from system clipboard more convenient
--
--map("n", '"cy', '"+y', { desc = "Paste System Clipboard" })
map("n", "cy", '"+y', { desc = "Yank System Clipboard" })
map("v", "cy", '"+y', { desc = "Yank System Clipboard" })
map("n", "cp", '"+p', { desc = "Paste System Clipboard" })
map("v", "cp", '"+p', { desc = "Paste System Clipboard" })

map("n", "cY", '"+Y', { desc = "Yank System Clipboard" })
map("v", "cY", '"+Y', { desc = "Yank System Clipboard" })
map("n", "cP", '"+P', { desc = "Paste System Clipboard" })
map("v", "cP", '"+P', { desc = "Paste System Clipboard" })

--keys to resize window
map("n", "<C-Left>", "<cmd>:vertical resize -5<CR>", { desc = "Vertical resize window(-)" })
map("n", "<C-Right>", ":vertical resize +5<CR>", { desc = "Vertical resize window(+)" })
map("n", "<C-Up>", ":horizontal resize +2<CR>", { desc = "Horizontal resize window(+)" })
map("n", "<C-Down>", ":horizontal resize -2<CR>", { desc = "Horizontal resize window(-)" })
--resize window options for mac and dvorak (somehow ctrl+navigation doesn't work)
map("n", "=", ":vertical resize +5<CR>", { desc = "Vertical resize window(+)" })
map("n", "-", "<cmd>:vertical resize -5<CR>", { desc = "Vertical resize window(-)" })
map("n", "+", ":horizontal resize +2<CR>", { desc = "Horizontal resize window(+)" })
map("n", "_", ":horizontal resize -2<CR>", { desc = "Horizontal resize window(-)" })
--NOTE: Add C-Space A-Space mapping in cmp config (completion)
--NOTE: double tap diagnostic hover (K) to enter the opened popup

--NOTE: Default inside and around commands do not execute for next
-- but rather the one that cursor is inside.
-- So, this mappings do search for next one and then do the editing.
-- For normal behaviour use with step e.g. c1i[
-- Removed these because they were not working and surprisingly lazyvim has cin[ mappings
-- local chars = { '"', "'", "(", "[", "{", "<" }
-- for _, char in ipairs(chars) do
--   for _, op in ipairs({ "c", "d", "v" }) do
--     vim.keymap.set("n", op .. "i" .. char, "f" .. char .. op .. "i" .. char, { noremap = true })
--     vim.keymap.set("n", op .. "a" .. char, "f" .. char .. op .. "a" .. char, { noremap = true })
--   end
-- end

-- NOTE: File Explorer mappings (single source of truth)
-- Controlled by _G.yeet.plugins.editor.file_explorer in plugins/config.lua
-- Default is snacks.explorer. Overridden when neo-tree, mini_files, or oil is selected.
-- Each plugin still keeps its own direct-access keys (e.g. <leader>fn, <leader>fm, <leader>fo).
local file_explorer = _G.yeet.plugins.editor.file_explorer or "snacks"
local explorer_actions = {
  snacks = {
    cwd = function() Snacks.explorer() end,
    root = function() Snacks.explorer({ cwd = LazyVim.root() }) end,
  },
  ["neo-tree"] = {
    cwd = function() require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() }) end,
    root = function() require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() }) end,
  },
  mini_files = {
    cwd = function() require("mini.files").open(vim.uv.cwd(), true) end,
    root = function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end,
  },
  oil = {
    cwd = function() require("oil").toggle_float() end,
    root = function() require("oil").open() end,
  },
}
local actions = explorer_actions[file_explorer]
if actions then
  map("n", "<leader>fe", actions.cwd, { desc = "File Explorer (cwd)" })
  map("n", "<leader>fE", actions.root, { desc = "File Explorer (Root Dir)" })
end
map("n", "<leader>e", "<leader>fe", { desc = "File Explorer (cwd)", remap = true })
map("n", "<leader>E", "<leader>fE", { desc = "File Explorer (Root Dir)", remap = true })

--NOTE: Some fancy keymappings for not being able to remember them
map("n", "<leader>fs", "<cmd>noautocmd w<cr>", { desc = "Save without formatting" })
-- save file
-- there is a problem while saving it inserts inputs
-- probably because formatting is too slow, not this mapping
-- map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- LazyVim v15.14.0 Defaults for Git (remapped under <leader>gv for Vanilla) --
--#region
--NOTE: Left git commits in fzf-lua and git-explorer in neotree for now 
-- LazyGit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gu", function() Snacks.lazygit({ cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gU", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>gvg", function() Snacks.lazygit({ cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gvG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
end
map("n", "<leader>gvd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (hunks)" })
map("n", "<leader>gvs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>gvS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
map("n", "<leader>gvL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" })
map("n", "<leader>gvb", function() Snacks.picker.git_log_line() end, { desc = "Git Blame Line" })
map("n", "<leader>gvf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
map("n", "<leader>gvl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, { desc = "Git Log" })
map({ "n", "x" }, "<leader>gvB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
map({ "n", "x" }, "<leader>gvY", function()
  Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
end, { desc = "Git Browse (copy)" })
--#endregion

--NOTE: put it here for reminding, probably never gonna use 
--and overridden by neotree. 
--map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
