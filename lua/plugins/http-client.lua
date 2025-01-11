return {
	{
		"mistweaverco/kulala.nvim",
		lazy = true,
		config = function()
			-- Setup is required, even if you don't pass any options
			require("kulala").setup()
			vim.filetype.add({
				extension = {
					["http"] = "http",
				},
			})
		end,
	},
}
