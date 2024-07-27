return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"marilari88/neotest-vitest",
			"nvim-neotest/neotest-python",
		},
		config = function()
			require("neotest").setup({
				adapters = { require("neotest-vitest"), require("neotest-python") },
			})
			vim.keymap.set("n", "<leader>Ntr", "<cmd>lua require('neotest').run.run()<cr>")
			vim.keymap.set("n", "<leader>Nts", "<cmd>lua require('neotest').run.stop()<cr>")
			vim.keymap.set("n", "<leader>Nto", "<cmd>lua require('neotest').output.open()<cr>")
			vim.keymap.set("n", "<leader>Ntp", "<cmd>lua require('neotest').output_panel.toggle()<cr>")
		end,
	},
}
