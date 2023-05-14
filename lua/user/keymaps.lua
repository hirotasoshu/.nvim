-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Telekasten
-- On hesitation, bring up the command panel
keymap("n", "<leader>z", "<cmd>lua require('telekasten').panel()<CR>")

-- Function mappings
keymap("n", "<leader>zf", ":lua require('telekasten').find_notes()<CR>")
keymap("n", "<leader>zd", ":lua require('telekasten').find_daily_notes()<CR>")
keymap("n", "<leader>zg", ":lua require('telekasten').search_notes()<CR>")
keymap("n", "<leader>zz", ":lua require('telekasten').follow_link()<CR>")
keymap("n", "<leader>zT", ":lua require('telekasten').goto_today()<CR>")
keymap("n", "<leader>zW", ":lua require('telekasten').goto_thisweek()<CR>")
keymap("n", "<leader>zw", ":lua require('telekasten').find_weekly_notes()<CR>")
keymap("n", "<leader>zn", ":lua require('telekasten').new_note()<CR>")
keymap("n", "<leader>zN", ":lua require('telekasten').new_templated_note()<CR>")
keymap("n", "<leader>zy", ":lua require('telekasten').yank_notelink()<CR>")
keymap("n", "<leader>zc", ":lua require('telekasten').show_calendar()<CR>")
keymap("n", "<leader>zC", ":CalendarT<CR>")
keymap("n", "<leader>zi", ":lua require('telekasten').paste_img_and_link()<CR>")
keymap("n", "<leader>zt", ":lua require('telekasten').toggle_todo()<CR>")
keymap("n", "<leader>zb", ":lua require('telekasten').show_backlinks()<CR>")
keymap("n", "<leader>zF", ":lua require('telekasten').find_friends()<CR>")
keymap("n", "<leader>zI", ":lua require('telekasten').insert_img_link({ i=true })<CR>")
keymap("n", "<leader>zp", ":lua require('telekasten').preview_img()<CR>")
keymap("n", "<leader>zm", ":lua require('telekasten').browse_media()<CR>")
keymap("n", "<leader>za", ":lua require('telekasten').show_tags()<CR>")
keymap("n", "<leader>#", ":lua require('telekasten').show_tags()<CR>")
keymap("n", "<leader>zr", ":lua require('telekasten').rename_note()<CR>")
