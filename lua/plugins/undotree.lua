return {
	{
		"mbbill/undotree",
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", {})
		end
	}
}
