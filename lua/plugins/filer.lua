return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				reload_on_bufenter = true,
				update_focused_file = {
					enable = true,
					update_root = {
						enable = true,
					},
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
				},
				modified = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true,
				},
				filters = {
					git_ignored = false,
					dotfiles = false,
				},
			})
			vim.keymap.set("n", "<leader>nt", "<cmd>NvimTreeToggle<CR>", {})
		end,
	},
}
