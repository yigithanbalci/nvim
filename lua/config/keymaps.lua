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
