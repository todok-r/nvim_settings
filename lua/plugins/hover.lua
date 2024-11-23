local util = vim.lsp.util

local ___ =
	"\n─────────────────────────────────────────────────────────────────────────────\n"

local LSPWithDiagSource = {
	name = "LSPWithDiag",
	priority = 1000,
	enabled = function()
		return true
	end,
	execute = function(done)
		local params = util.make_position_params()
		vim.lsp.buf_request_all(0, "textDocument/hover", params, function(responses)
			local value = ""
			for _, response in pairs(responses) do
				local result = response.result
				if result and result.contents and result.contents.value then
					if value ~= "" then
						value = value .. ___
					end
					value = value .. result.contents.value
				end
			end

			local _, row = unpack(vim.fn.getpos("."))
			local lineDiag = vim.diagnostic.get(0, { lnum = row - 1 })
			for _, d in pairs(lineDiag) do
				if d.message then
					if value ~= "" then
						value = value .. ___
					end
					value = value .. string.format("*%s* %s", d.source, d.message)
				end
			end
			value = value:gsub("\r", "")

			if value ~= "" then
				done({ lines = vim.split(value, "\n", true), filetype = "markdown" })
			else
				done()
			end
		end)
	end,
}

return {
	"lewis6991/hover.nvim",
	config = function()
		require("hover").setup({
			init = function()
				-- Require providers
				require("hover").register(LSPWithDiagSource)
				-- require("hover.providers.lsp")
				-- require('hover.providers.gh')
				-- require('hover.providers.gh_user')
				-- require('hover.providers.jira')
				-- require("hover.providers.dap")
				-- require('hover.providers.fold_preview')
				-- require("hover.providers.diagnostic")
				-- require("hover.providers.man")
				require("hover.providers.dictionary")
			end,
			preview_opts = {
				border = "single",
			},
			-- Whether the contents of a currently open hover window should be moved
			-- to a :h preview-window when pressing the hover keymap.
			preview_window = false,
			title = true,
			mouse_providers = {
				"LSP",
			},
			mouse_delay = 1000,
		})

		-- Setup keymaps
		--vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
		--vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, {desc = "hover.nvim (previous source)"})
		--vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, {desc = "hover.nvim (next source)"})
	end,
}
