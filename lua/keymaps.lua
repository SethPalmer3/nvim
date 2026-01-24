-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.get_prev, { float = false, desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.get_next, { float = false, desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', ']w', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end,
--   { desc = 'Go to next warning' })
-- vim.keymap.set('n', '[w', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end,
--   { desc = 'Go to previous warning' })
-- vim.keymap.set('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
--   { desc = 'Go to next error' })
-- vim.keymap.set('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
--   { desc = 'Go to previous error' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- keymap("n", "[b", ":bprevious<CR>", default_opts)
-- keymap("n", "]b", ":bnext<CR>", default_opts)
-- keymap("n", "[B", ":bfirst<CR>", default_opts)
-- keymap("n", "]B", ":blast<CR>", default_opts)
keymap("n", "<C-u>", "<C-u>zz", default_opts)
keymap("n", "<C-d>", "<C-d>zz", default_opts)
keymap("n", "<C-b>", "<C-b>zz", default_opts)
keymap("n", "<C-f>", "<C-f>zz", default_opts)
-- keymap("n", "[t", "gT", default_opts)
-- keymap("n", "]t", "gt", default_opts)
vim.keymap.set('n', '<leader>uo', vim.cmd.UndotreeToggle, { desc = "Open the undo tree window" })
