return {
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("spectre").setup()
		end,
		keys = require("config.keymaps").setup_spectre_keymaps(),
	},
}
