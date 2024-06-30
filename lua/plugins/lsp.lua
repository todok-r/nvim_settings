return {
	{ 'neovim/nvim-lspconfig' },
	{ 'williamboman/mason.nvim' },
	{ 'onsails/lspkind.nvim' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'hrsh7th/nvim-cmp' },
	{
		'nvimdev/lspsaga.nvim',
		--		commit = "a17c975ac2eaa96736458d0a2cdd6abeb8f7811f",
		commit = "6f920cf",
		config = function()
			require('lspsaga').setup({
				code_action = {
					extend_gitsigns = true,
				},
			})
		end,
		dependencies = {
			'nvim-treesitter/nvim-treesitter', -- optional
			'nvim-tree/nvim-web-devicons', -- optional
		}
	},
	{ 'kosayoda/nvim-lightbulb' },
	{ 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
	{ "williamboman/mason-lspconfig.nvim" },
	{ 'nvimtools/none-ls.nvim' },
}
