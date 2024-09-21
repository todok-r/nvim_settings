return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		config = function()
			require("telescope").setup({
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
			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")
			local wk = require("which-key")
			wk.add({
				mode = { "n" }, -- NORMAL and VISUAL mode
				{ "<leader>ff", builtin.find_files, desc = "Telescope find files" },
				{ "<leader>fg", builtin.live_grep, desc = "Telescope live grep" },
				{ "<leader>fb", builtin.buffers, desc = "Telescope buffers" },
				{ "<leader>fh", builtin.help_tags, desc = "Telescope help tags" },
				{ "<leader>ft", "<cmd>Telescope<cr>", desc = "Telescope" },
			})
		end,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
