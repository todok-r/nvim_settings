return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			vim.keymap.set("n", "<leader>dc", '<cmd>lua require("dap").continue()<cr>')
			vim.keymap.set("n", "<leader>dsv", '<cmd>lua require("dap").step_over() <cr>')
			vim.keymap.set("n", "<leader>dsi", '<cmd>lua require("dap").step_into() <cr>')
			vim.keymap.set("n", "<leader>dso", '<cmd>lua require("dap").step_out() <cr>')
			vim.keymap.set("n", "<Leader>db", '<cmd>lua require("dap").toggle_breakpoint() <cr>')
			vim.keymap.set("n", "<Leader>dB", '<cmd>lua require("dap").set_breakpoint() <cr>')
			vim.keymap.set(
				"n",
				"<Leader>dlp",
				'<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) <cr>'
			)
			vim.keymap.set("n", "<Leader>dr", '<cmd>lua require("dap").repl.open() <cr>')
			vim.keymap.set("n", "<Leader>dl", '<cmd>lua require("dap").run_last() <cr>')
			vim.keymap.set({ "n", "v" }, "<Leader>dh", '<cmd>lua require("dap.ui.widgets").hover() <cr>')
			vim.keymap.set({ "n", "v" }, "<Leader>dp", '<cmd>lua require("dap.ui.widgets").preview() <cr>')
			vim.keymap.set(
				"n",
				"<Leader>df",
				'<cmd>lua require("dap.ui.widgets").widgets.centered_float(widgets.frames)<cr>'
			)
			vim.keymap.set("n", "<Leader>dsc", '<cmd>lua require("dap.ui.widgets").centered_float(widgets.scopes)')
		end,
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			require("dap-python").setup("python")
		end,
	},
}
