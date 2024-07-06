vim.g.mapleader = '\\'
vim.g.maplocalleader = ' '

require("config.lazy")

vim.opt.mouse = ''
vim.opt.foldmethod = 'marker'
vim.opt.visualbell = true
vim.opt.cursorline = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.grepprg = 'egrep'
vim.opt.equalalways = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.textwidth = 0

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.api.nvim_set_keymap('', '<F1>', '<ESC>', {})
vim.api.nvim_set_keymap('c', '<C-B>', '<Left>', {})
vim.api.nvim_set_keymap('c', '<C-A>', '<Home>', {})
vim.api.nvim_set_keymap('c', '<C-E>', '<End>', {})
vim.api.nvim_set_keymap('c', '<C-D>', '<Delete>', {})

vim.cmd("colorscheme kanagawa")
vim.opt.termguicolors = true
