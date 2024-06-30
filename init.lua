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

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- indent-blankline
local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

--colorscheme
vim.cmd("colorscheme kanagawa")
vim.opt.termguicolors = true
require("bufferline").setup {}

--snippets
require("luasnip.loaders.from_snipmate").lazy_load()
local ls = require("luasnip")

vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

require('nvim-ts-autotag').setup()

-- LSP
-- LSP package manager
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	lsp_zero.default_keymaps({ buffer = bufnr })
	vim.keymap.set('n', '<leader><C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
--	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '<leader>gq', vim.lsp.buf.format, bufopts)
	vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
	--vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<leader>gI', "<cmd>Lspsaga peek_definition<CR>", bufopts)
	--vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, bufopts)
	vim.keymap.set('n', ']g', vim.diagnostic.goto_next, bufopts)

	vim.keymap.set('v', '<leader>gq', vim.lsp.buf.format, bufopts)

	vim.keymap.set('n', 'K', "<cmd>Lspsaga hover<CR>", bufopts)
	vim.keymap.set('n', '<leader>ca', "<cmd>Lspsaga code_action<CR>", bufopts)
	vim.keymap.set('n', '[G', "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
	vim.keymap.set('n', ']G', "cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
	vim.keymap.set('n', ']G', "cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
	vim.keymap.set('n', '<leader>F', "<cmd>Lspsaga finder<CR>", bufopts)
	vim.keymap.set('n', '<leader>rn', "<cmd>Lspsaga rename<CR>", bufopts)

end)

lsp_zero.set_server_config({
	on_init = function(client)
--		client.server_capabilities.semanticTokensProvider = nil
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentFormattingRangeProvider = false
	end,
})

-- to learn how to use mason.nvim
-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = { 'tsserver', 'pyright', 'html', 'clangd', 'bashls', 'jsonls', 'lua_ls' },
	handlers = {
		lsp_zero.default_setup,
	},
})

-- Set up nvim-cmp.
local cmp = require 'cmp'

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			-- { name = 'vsnip' }, -- For vsnip users.
			{ name = 'luasnip' }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		},
		{
			{ name = 'buffer' },
		})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})

-- null-ls/none-ls
local status, null_ls = pcall(require, "none-ls")
if (not status) then return end

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
	}
})

--require('lspsaga').setup({})
