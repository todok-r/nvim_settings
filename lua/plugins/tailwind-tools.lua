-- tailwind-tools.lua
return {
	"luckasRanarison/tailwind-tools.nvim",
	lazy = true,
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- optional
		"neovim/nvim-lspconfig", -- optional
	},
--	opts = {}, -- your configuration
}
