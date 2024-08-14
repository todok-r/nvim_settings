vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")

vim.opt.mouse = ""
vim.opt.foldmethod = "marker"
vim.opt.visualbell = true
vim.opt.cursorline = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.grepprg = "egrep"
vim.opt.equalalways = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 0

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.api.nvim_set_keymap("", "<F1>", "<ESC>", {})
vim.api.nvim_set_keymap("c", "<C-B>", "<Left>", {})
vim.api.nvim_set_keymap("c", "<C-A>", "<Home>", {})
vim.api.nvim_set_keymap("c", "<C-E>", "<End>", {})
vim.api.nvim_set_keymap("c", "<C-D>", "<Delete>", {})

vim.api.nvim_set_keymap("n", "<leader>so", "<cmd>source $MYVIMRC<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>tabe $MYVIMRC<CR>", {})
--vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {})

vim.cmd("colorscheme rose-pine-moon")
