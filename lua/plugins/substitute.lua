return {
	{
		"gbprod/substitute.nvim",
		config = function()
			require("substitute").setup()
		end,
		keys = require("config.keymaps").setup_substitute_keymaps(),
	},
}
