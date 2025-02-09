-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`

-----------------------------------------------------------------------------
-- NOTE: If you aren't using colemak, comment these out

-- Moves through display-lines, unless count is provided
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Down" })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Up" })

-- Repurpose hjkl for window switching
vim.keymap.set("n", "l", "<c-w>h", { noremap = true })
vim.keymap.set("n", "h", "<c-w>l", { noremap = true })
vim.keymap.set("n", "j", "<c-w>k", { noremap = true })
vim.keymap.set("n", "k", "<c-w>j", { noremap = true })

-----------------------------------------------------------------------------

-- Reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
vim.keymap.set("n", "<leader>v", "printf('`[%s`]', getregtype()[0])", {
  expr = true,
  desc = "reselect last pasted area",
})

-- Always use very magic mode for searching
vim.keymap.set("n", "/", [[/\v]])

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
vim.keymap.set("n", "cc", '"_cc')
vim.keymap.set("x", "c", '"_c')

-- Replace visual selection with text in register, but not contaminate the register,
-- see also https://stackoverflow.com/q/10723700/6064933.
vim.keymap.set("x", "p", '"_c<Esc>p')

-- insert semicolon at the end of line when in insert mode
vim.keymap.set("i", "<A-;>", "<Esc>miA;<Esc>`ii")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>qq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- Disable in lazygit and ignore key in which key
vim.keymap.set("t", "<Esc><Esc>", function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name:match("lazygit") or buf_name:match("yazi") then
    return "<Esc>"
  else
    return "<C-\\><C-n>"
  end
end, { expr = true, nowait = true, desc = "which_key_ignore" })

-- TODO: Configure Lazygit current file history (see lazyvim.lazygit)
vim.keymap.set("n", "<leader>lf", function()
  local git_path = vim.api.nvim_buf_get_name(0)
  require("custom.functions.lazygit")({ args = { "-f", vim.trim(git_path) } })
end, { desc = "Lazygit Current File History" })

-- Shift tab to dedent
vim.keymap.set("i", "<S-Tab>", "<C-d>", { noremap = true, silent = true })

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Quit
vim.keymap.set("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit All" })

-- windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
vim.keymap.set("n", "<leader>w-", "<C-W>v", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>w|", "<C-W>s", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>-", "<C-W>v", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>s", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>wc", "<cmd>windo diffthis<cr>", { desc = "[c]ompare [w]indows" })

-- Run Lua code
vim.keymap.set("n", "<leader>lr", "<cmd>.lua<CR>", { desc = "Run current line as Lua code" })
vim.keymap.set("v", "<leader>lR", [[<Esc><cmd>'<,'>lua<CR>]], { desc = "Run selected lines as Lua code" })

-----------------------------------------------------------------------------
-- Iswap - swap parameters or textobjects
vim.keymap.set("n", "<leader>is", ":ISwapWith<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>in", ":ISwapNodeWith<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ih", ":ISwapNode<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>io", ":ISwap<CR>", { noremap = true, silent = true })

-----------------------------------------------------------------------------
-- Chainsaw logging Plugin

-- log the name & value of the variable under the cursor
-- stylua: ignore
vim.keymap.set("n", "<leader>clv", '<cmd>lua require("chainsaw").variableLog() <CR>',{ noremap = true, silent = true, desc = "[c]hainsaw [l]og [v]ariable" })
vim.keymap.set(
  "n",
  "<leader>clo",
  '<cmd>lua require("chainsaw").objectLog()<CR>',
  { noremap = true, silent = true, desc = "[c]hainsaw [l]og [o]bject" }
)

-- inspect the type of the variable under cursor, such as `typeof foo` in js
vim.keymap.set(
  "n",
  "<leader>clt",
  '<cmd>lua require("chainsaw").typeLog()<CR>',
  { noremap = true, silent = true, desc = "[c]hainsaw [l]og [t]ype" }
)

-- assertion statement for variable under cursor
vim.keymap.set(
  "n",
  "<leader>cla",
  '<cmd>lua require("chainsaw").assertLog()<CR>',
  { noremap = true, silent = true, desc = "[c]hainsaw [l]og [a]ssert" }
)

-- Minimal log statement, with an emoji for differentiation. Intended for
-- control flow inspection, i.e. to quickly glance whether a condition was
-- triggered or not. (Inspired by AppleScript's `beep` command.)
vim.keymap.set(
  "n",
  "<leader>clb",
  '<cmd>lua require("chainsaw").beepLog()<CR>',
  { noremap = true, silent = true, desc = "[c]hainsaw [l]og [b]eep" }
)

-- create log statement, and position the cursor to enter a message
vim.keymap.set(
  "n",
  "<leader>clm",
  '<cmd>lua require("chainsaw").messageLog()<CR>',
  { noremap = true, silent = true, desc = "[c]hainsaw [l]og [m]essage" }
)

-- 1st call: start measuring the time
-- 2nd call: logs the time duration since
vim.keymap.set(
  "n",
  "<leader>clT",
  '<cmd>lua require("chainsaw").timeLog()<CR>',
  { noremap = true, silent = true, desc = "[c]hainsaw [l]og [T]ime" }
)

-- debug statements like `debugger` in javascript or `breakpoint()` in python
vim.keymap.set(
  "n",
  "<leader>cld",
  '<cmd>lua require("chainsaw").debugLog()<CR>',
  { noremap = true, silent = true, desc = "[c]hainsaw [l]og [d]ebug" }
)

-- prints the stacktrace of the current call
vim.keymap.set(
  "n",
  "<leader>cls",
  '<cmd>lua require("chainsaw").stacktraceLog()<CR>',
  { noremap = true, silent = true, desc = "[c]hainsaw [l]og [s]tackTrace" }
)

-- clearing statement, such as `console.clear()`
vim.keymap.set(
  "n",
  "<leader>clc",
  '<cmd>lua require("chainsaw").clearLog()<CR>',
  { noremap = true, silent = true, desc = "[c]hainsaw [l]og [c]lear" }
)

-- remove all log statements created by chainsaw
vim.keymap.set(
  "n",
  "<leader>clr",
  '<cmd>lua require("chainsaw").removeLogs()<CR>',
  { noremap = true, silent = true, desc = "[c]hainsaw [l]og [r]emove" }
)

-----------------------------------------------------------------------------
-- Cycle through todo comments
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { silent = true, desc = "Next Todo" })
vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { silent = true, desc = "Previous Todo" })

-----------------------------------------------------------------------------
--- Minty color picker
vim.keymap.set("n", "<leader>pc", "<cmd>Huefy<cr>")
vim.keymap.set("n", "<leader>ps", "<cmd>Shades<cr>")

-- Fix for multicursor clearing with ESC keymap
vim.keymap.set("n", "<esc>", function()
  local mc = require("multicursor-nvim")
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  else
    vim.cmd("noh")
    LazyVim.cmp.actions.snippet_stop()
    return "<esc>"
  end
end)


-- stylua: ignore
vim.keymap.set("n", "<c-\\>", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })

-- Autocommands go below ----
--
--
--  See `:help lua-guide-autocommands`

-- vim: ts=2 sts=2 sw=2 et
