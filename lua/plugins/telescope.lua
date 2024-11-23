return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		config = function()
			telescope = require("telescope")
			telescope.setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
				},
			})
			-- To get fzf loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")
			require("config.keymaps").setup_telescope_keymaps()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
