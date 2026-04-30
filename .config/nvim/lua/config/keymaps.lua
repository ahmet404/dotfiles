local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- Remap space as leader
map("n", "<Space>", "<Nop>", opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable keymap
map("n", "<Left>", "<Nop>")
map("n", "<Right>", "<Nop>")
map("n", "<Up>", "<Nop>")
map("n", "<Down>", "<Nop>")
map("n", "<C-z>", "<Nop>")

-- resize window
map("n", "<C-Left>", "<cmd>vertical resize +5<CR>", opt)
map("n", "<C-Right>", "<cmd>vertical resize -5<CR>", opt)
map("n", "<C-Up>", "<cmd>resize +5<CR>", opt)
map("n", "<C-Down>", "<cmd>resize -5<CR>", opt)

-- jump between window
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
map("n", "<A-w>", "<C-w>w", opt)

-- Navigate buffers
map("n", "<C-k>", "<cmd>bp<CR>", opt)
map("n", "<C-j>", "<cmd>bn<CR>", opt)

map("n", "<leader>z", " Buffer", opt)
map("n", "<leader>zz", "<cmd>Bdelete<CR>", opt)
map("n", "<leader>zx", "<cmd>%bd<CR>", opt)
map("n", "<leader>za", "<cmd>%bd!<CR>", opt)
map("n", "<leader>zb", "<cmd>%bd|e#<CR>", opt)

-- change type split window
map("n", "<C-A-k>", "<C-w>t<C-w>K", opt)
map("n", "<C-A-h>", "<C-w>t<C-w>H", opt)

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("n", "<S-j>", "<cmd>m .+1<CR>==", opt)
map("n", "<S-k>", "<cmd>m .-2<CR>==", opt)

-- map("t", "<Esc>", "<C-\\><C-n>", opt)

-- out of insert mode
map("i", "jk", "<Esc>")

-- BASIC --
map({ "n", "v" }, "<leader>w", "", { desc = "󰆓 Save & Load" })
map({ "n", "v" }, "<leader>ww", "<cmd>w!<cr>", { desc = "Save" })
map({ "n", "v" }, "<leader>we", "<cmd>source %<cr>", { desc = "Reload" })
map({ "n", "v" }, "<leader>q", "<cmd>q!<cr>", { desc = "󰿅 Quit" })
map({ "n", "v" }, "<leader>h", "<cmd>nohlsearch<cr>", { desc = "󱪿 No Highlight" })
map("n", "<leader>s", ":%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>", { desc = " Search & Replace" })

-- PLUGINS KEYMAPS --
-- LAZY --
map("n", "<leader>l", "", { desc = "󱑠 Lazy" })
map("n", "<leader>li", "<cmd>Lazy install<cr>", { desc = "Install" })
map("n", "<leader>ls", "<cmd>Lazy sync<cr>", { desc = "Sync" })
map("n", "<leader>lS", "<cmd>Lazy clear<cr>", { desc = "Status" })
map("n", "<leader>lc", "<cmd>Lazy clean<cr>", { desc = "Clean" })
map("n", "<leader>lu", "<cmd>Lazy update<cr>", { desc = "Update" })
map("n", "<leader>lp", "<cmd>Lazy profile<cr>", { desc = "Profile" })
map("n", "<leader>ll", "<cmd>Lazy log<cr>", { desc = "Log" })
map("n", "<leader>ld", "<cmd>Lazy debug<cr>", { desc = "Debug" })

-- GIT --
map("n", "<leader>g", "", { desc = " Git" })
map("n", "<leader>gj", function()
	require("gitsigns").nav_hunk("next")
end, { desc = "Next Hunk" })
map("n", "<leader>gk", function()
	require("gitsigns").nav_hunk("prev")
end, { desc = "Prev Hunk" })
map("n", "<leader>gl", function()
	require("gitsigns").blame_line()
end, { desc = "Blame" })
map("n", "<leader>gp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview Hunk" })
map("n", "<leader>gr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset Hunk" })
map("n", "<leader>gR", function()
	require("gitsigns").reset_buffer()
end, { desc = "Reset Buffer" })
map("n", "<leader>gs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage Hunk" })
map("n", "<leader>gu", function()
	require("gitsigns").stage_hunk()
end, { desc = "Undo Stage Hunk" })
map("n", "<Leader>gg", "<cmd>Neogit kind=vsplit<cr>", { desc = "Neogit" })
map("n", "<Leader>go", "<cmd>Telescope git_status<cr>", { desc = "Telescope: Git Status" })
map("n", "<Leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Telescope: Git Branch" })
map("n", "<Leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope: Git Commits" })
map("n", "<Leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", { desc = "Gitsigns: Git Diff" })

-- TELESCOPE --
map("n", "<leader>f", "", { desc = " Telescope" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find Text" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Open Recent File" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
map("n", "<leader>fC", "<cmd>Telescope colorscheme<cr>", { desc = "Colorscheme" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find Help" })
map("n", "<leader>fm", "<cmd>Telescope man_pages<cr>", { desc = "Man Pages" })
map("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Registers" })
map("n", "<leader>fn", "<cmd>Telescope builtin<cr>", { desc = "Builtin" })

-- CODERUNNER
map("n", "<leader>r", "", { desc = " Run" })
map("n", "<leader>rr", "<cmd>RunCode<cr>", { desc = "Run Code" })
map("n", "<leader>rf", "<cmd>RunFile<cr>", { desc = "Run File" })
map("n", "<leader>rp", "<cmd>RunProject<cr>", { desc = "Run Project" })

-- Neo-tree map
map("n", "`", "<cmd>Neotree filesystem reveal left<CR>", opt)

-- TROUBLE
map("n", "<Leader>tt", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble: Open diagnostics" })

-- MARKDOWN PREVIEW --
map("n", "<Leader>b", "<cmd>MarkdownPreview<cr>", { desc = " Markdown Preview" })
