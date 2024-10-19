return {
	{
		Lazy = true,
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
		end,
		keys = require("config.keymaps").setup_neotest_keymaps(),
	},
}
