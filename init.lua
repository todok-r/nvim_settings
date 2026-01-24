vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")
require("config.keymaps")
require("config.lsp")

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
require("nvim-treesitter.configs").setup({
  indent = {
    enable = true,
    -- python だけで有効化したいなら
    -- disable = function(lang)
    --   return lang ~= "python"
    -- end
  },
})
vim.opt.textwidth = 0

vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.signcolumn = "yes:1"
vim.opt.scroll = 10
vim.opt.scrolloff = 999
vim.opt.relativenumber = true
vim.opt.inccommand = "split"

vim.cmd("colorscheme rose-pine-moon")
