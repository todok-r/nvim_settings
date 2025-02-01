return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					require("config.keymaps").setup_gitsigns_keymaps(bufnr)
				end,
			})
		end,
	},
	{ "sindrets/diffview.nvim" },
}
