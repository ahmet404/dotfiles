-- normal_mode = "n",
-- insert_mode = "i",
-- visual_block_mode = "x",
-- visual_mode = "v",
-- term_mode = "t",
-- command_mode = "c",

local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- Remap space as leader
map("", "<Space>", "<Nop>", opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable keymap
map("n", "<Left>", "<Nop>")
map("n", "<Right>", "<Nop>")
map("n", "<Up>", "<Nop>")
map("n", "<Down>", "<Nop>")
map("n", "<C-z>", "<Nop>")
map("n", "<C-r>", "<Nop>")
map("n", "<C-y>", "<cmd>redo<CR>", opt)
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
map("n", "<leader>q", "<cmd>Bdelete<CR>", opt)
map("n", "<leader>qq", "<cmd>%bd<CR>", opt)
map("n", "<leader>qa", "<cmd>%bd!<CR>", opt)
map("n", "<leader>qo", "<cmd>%bd|e#<CR>", opt)

-- change type split window
map("n", "<C-A-k>", "<C-w>t<C-w>K", opt)
map("n", "<C-A-h>", "<C-w>t<C-w>H", opt)

-- hide hightlight search
map("n", "<leader>h", "<cmd>nohlsearch<CR>", opt)

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("n", "<S-j>", "<cmd>m .+1<CR>==", opt)
map("n", "<S-k>", "<cmd>m .-2<CR>==", opt)

--map("t", "<Esc>", "<C-\\><C-n>", opts)

-- out of insert mode
map("i", "jk", "<Esc>")

-- Search and Replace
map("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opt)

-- Neo-tree map
map("n", "`", "<cmd>Neotree reveal<CR>", opt)

-- telescope map
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opt)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opt)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opt)
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", opt)
map("n", "<leader>fm", "<cmd>Telescope marks<cr>", opt)
map("n", "<leader>fk", "<cmd>Telescope maps<cr>", opt)
map("n", "<leader>fc", "<cmd>Telescope commands<cr>", opt)
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", opt)
map("n", "<leader><leader>", "<cmd>Telescope builtin<cr>", opt)

-- code runner map
map("n", "<leader>r", ":RunCode<CR>", opt)
map("n", "<leader>rf", ":RunFile<CR>", opt)
map("n", "<leader>rft", ":RunFile tab<CR>", opt)
map("n", "<leader>rp", ":RunProject<CR>", opt)
map("n", "<leader>rc", ":RunClose<CR>", opt)
map("n", "<leader>crf", ":CRFiletype<CR>", opt)
map("n", "<leader>crp", ":CRProjects<CR>", opt)
