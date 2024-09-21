return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup()
			require("config.keymaps").toggleterm_keymaps()
		end,
	},
}
