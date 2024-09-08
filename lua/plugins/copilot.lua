return {
	--{ "github/copilot.vim" },
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
		cmd = "Copilot",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<tab>",
						next = "<C-n>",
						prev = "<C-p>",
						dismiss = "<Esc>",
					},
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		config = function()
			require("CopilotChat").setup({ debug = true })
			vim.keymap.set("n", "<leader>cct", "<cmd>CopilotChatToggle<cr>", { desc = "toggle copilot chat window" })
			vim.keymap.set("v", "<leader>ccq", function()
				local input = vim.fn.input("Quick Chat: ")
				local selection = require("mylib.utils").get_visual_selection()

				input = input .. " " .. selection .. "\n"

				if input ~= "" then
					require("CopilotChat").ask(input)
				end
			end, { desc = "ask copilot chat about selected lines" })
			vim.keymap.set("n", "<leader>ccq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end, { desc = "CopilotChat - Quick chat" })
		end,
	},
}
