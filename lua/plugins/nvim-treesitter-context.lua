return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			vim.keymap.set("n", "<leader>tsct", "<cmd>TSContextToggle<CR>")
		end,
	},
}
