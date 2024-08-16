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
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			"mfussenegger/nvim-dap",
			{
				"microsoft/vscode-js-debug",
				-- build = "npm install --legacy-peer-deps && npm run compile",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			},
		},
		config = function()
			require("dap-vscode-js").setup({
				-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
				-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
				-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
				-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
				-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},
}
