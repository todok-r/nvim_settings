local M = {}

-- basic settings
vim.api.nvim_set_keymap("", "<F1>", "<ESC>", {})
vim.api.nvim_set_keymap("c", "<C-B>", "<Left>", {})
vim.api.nvim_set_keymap("c", "<C-A>", "<Home>", {})
vim.api.nvim_set_keymap("c", "<C-E>", "<End>", {})
vim.api.nvim_set_keymap("c", "<C-D>", "<Delete>", {})

vim.api.nvim_set_keymap("n", "<leader>so", "<cmd>source $MYVIMRC<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>tabe $MYVIMRC<CR>", {})
--vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {})
vim.api.nvim_set_keymap("n", "<C-j>", "<cmd>cnext<CR>", {})
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>cprev<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>lcd", ":lcd %:p:h<CR>", { noremap = true, silent = true })

--copilot
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

--substitute
vim.keymap.set("n", "s", require("substitute").operator, { noremap = true, desc = "Substitute: Operator" })
vim.keymap.set("n", "ss", require("substitute").line, { noremap = true, desc = "Substitute: Line" })
vim.keymap.set("n", "S", require("substitute").eol, { noremap = true, desc = "Substitute: End of Line" })
vim.keymap.set("x", "s", require("substitute").visual, { noremap = true, desc = "Substitute: Visual" })
vim.keymap.set("n", "<leader>s", require("substitute.range").operator, { noremap = true, desc = "Substitute Range: Operator" })
vim.keymap.set("x", "<leader>s", require("substitute.range").visual, { noremap = true, desc = "Substitute Range: Visual" })
vim.keymap.set("n", "<leader>ss", require("substitute.range").word, { noremap = true, desc = "Substitute Range: Word" })
vim.keymap.set("n", "sx", require("substitute.exchange").operator, { noremap = true, desc = "Substitute Exchange: Operator" })
vim.keymap.set("n", "sxx", require("substitute.exchange").line, { noremap = true, desc = "Substitute Exchange: Line" })
vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true, desc = "Substitute Exchange: Visual" })
vim.keymap.set("n", "sxc", require("substitute.exchange").cancel, { noremap = true, desc = "Substitute Exchange: Cancel" })

--neotest
vim.keymap.set("n", "<leader>Ntr", "<cmd>lua require('neotest').run.run()<cr>")
vim.keymap.set("n", "<leader>Nts", "<cmd>lua require('neotest').run.stop()<cr>")
vim.keymap.set("n", "<leader>Nto", "<cmd>lua require('neotest').output.open()<cr>")
vim.keymap.set("n", "<leader>Ntp", "<cmd>lua require('neotest').output_panel.toggle()<cr>")

--snippet
local ls = require("luasnip")

vim.keymap.set({ "i" }, "<C-K>", function()
	ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
	ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
	ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

--undotree
vim.api.nvim_set_keymap("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", {})

--nvim-spectre
vim.keymap.set("n", "<leader>St", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})
vim.keymap.set("n", "<leader>Sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
vim.keymap.set("v", "<leader>Sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
vim.keymap.set("n", "<leader>Sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

--nvim-tree
vim.keymap.set("n", "<leader>ntt", "<cmd>NvimTreeToggle<CR>", {})
vim.keymap.set("n", "<leader>ntf", "<cmd>NvimTreeFocus<CR>", {})

--nvim-tree-preview
function M.nvim_tree_preview_keymaps(bufnr)
	local api = require("nvim-tree.api")

	-- Important: When you supply an `on_attach` function, nvim-tree won't
	-- automatically set up the default keymaps. To set up the default keymaps,
	-- call the `default_on_attach` function. See `:help nvim-tree-quickstart-custom-mappings`.
	api.config.mappings.default_on_attach(bufnr)

	local function opts(desc)
		return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		}
	end

	local preview = require("nvim-tree-preview")

	vim.keymap.set("n", "P", preview.watch, opts("Preview (Watch)"))
	vim.keymap.set("n", "<Esc>", preview.unwatch, opts("Close Preview/Unwatch"))

	-- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
	vim.keymap.set("n", "<Tab>", function()
		local ok, node = pcall(api.tree.get_node_under_cursor)
		if ok and node then
			if node.type == "directory" then
				api.node.open.edit()
			else
				preview.node(node, { toggle_focus = true })
			end
		end
	end, opts("Preview"))

	-- Option B: Simple tab behavior: Always preview
	-- vim.keymap.set('n', '<Tab>', preview.node_under_cursor, opts 'Preview')
end

--DAP
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
vim.keymap.set("n", "<Leader>df", '<cmd>lua require("dap.ui.widgets").widgets.centered_float(widgets.frames)<cr>')
vim.keymap.set("n", "<Leader>dsc", '<cmd>lua require("dap.ui.widgets").centered_float(widgets.scopes)')

function M.toggleterm_keymaps()
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({
		cmd = "lazygit",
		dir = "git_dir",
		direction = "float",
		float_opts = {
			border = "double",
		},
		-- function to run on opening the terminal
		on_open = function(_)
			vim.cmd("startinsert!")
		end,
		-- function to run on closing the terminal
		on_close = function(_)
			vim.cmd("startinsert!")
		end,
	})

	function Lazygit_toggle()
		lazygit:toggle()
	end

	vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })
end

--todo-comments
vim.keymap.set("n", "<leader>tcn", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "<leader>tcp", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

--indent-blankline
vim.api.nvim_set_keymap("n", "<leader>ibl", "<cmd>IBLToggle<CR>", {})

--lsp
function M.lsp_keymaps(bufnr)
	local lsp_zero = require("lsp-zero")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	lsp_zero.default_keymaps({ buffer = bufnr })

	vim.keymap.set(
		"n",
		"<leader><C-k>",
		vim.lsp.buf.signature_help,
		vim.tbl_extend("force", bufopts, { desc = "LSP: Signature Help" })
	)
	vim.keymap.set(
		"n",
		"<leader>D",
		vim.lsp.buf.type_definition,
		vim.tbl_extend("force", bufopts, { desc = "LSP: Type Definition" })
	)
	vim.keymap.set("n", "<leader>gq", vim.lsp.buf.format, vim.tbl_extend("force", bufopts, { desc = "LSP: Format" }))
	vim.keymap.set(
		"n",
		"<leader>gr",
		"<cmd>Telescope lsp_references<cr>",
		vim.tbl_extend("force", bufopts, { desc = "LSP: References" })
	)
	vim.keymap.set(
		"n",
		"<leader>wa",
		vim.lsp.buf.add_workspace_folder,
		vim.tbl_extend("force", bufopts, { desc = "LSP: Add Workspace Folder" })
	)
	vim.keymap.set(
		"n",
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		vim.tbl_extend("force", bufopts, { desc = "LSP: Remove Workspace Folder" })
	)
	vim.keymap.set(
		"n",
		"<leader>gD",
		vim.lsp.buf.declaration,
		vim.tbl_extend("force", bufopts, { desc = "LSP: Declaration" })
	)
	vim.keymap.set(
		"n",
		"<leader>gd",
		vim.lsp.buf.definition,
		vim.tbl_extend("force", bufopts, { desc = "LSP: Definition" })
	)
	vim.keymap.set(
		"n",
		"<leader>gi",
		vim.lsp.buf.implementation,
		vim.tbl_extend("force", bufopts, { desc = "LSP: Implementation" })
	)
	vim.keymap.set(
		"n",
		"<leader>gI",
		"<cmd>Lspsaga peek_definition<CR>",
		vim.tbl_extend("force", bufopts, { desc = "Lspsaga: Peek Definition" })
	)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "LSP: Hover" }))
	-- vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, bufopts)
	-- vim.keymap.set("n", "]g", vim.diagnostic.goto_next, bufopts)

	vim.keymap.set(
		"v",
		"<leader>gq",
		vim.lsp.buf.format,
		vim.tbl_extend("force", bufopts, { desc = "LSP: Format (Visual)" })
	)

	-- vim.keymap.set("n", "K", "<cmd>Lspsaga hover<CR>", bufopts)
	vim.keymap.set(
		"n",
		"<leader>ca",
		"<cmd>Lspsaga code_action<CR>",
		vim.tbl_extend("force", bufopts, { desc = "Lspsaga: Code Action" })
	)
	vim.keymap.set(
		"n",
		"[g",
		"<cmd>Lspsaga diagnostic_jump_prev<CR>",
		vim.tbl_extend("force", bufopts, { desc = "Lspsaga: Diagnostic Jump Prev" })
	)
	vim.keymap.set(
		"n",
		"]g",
		"<cmd>Lspsaga diagnostic_jump_next<CR>",
		vim.tbl_extend("force", bufopts, { desc = "Lspsaga: Diagnostic Jump Next" })
	)
	vim.keymap.set(
		"n",
		"<leader>F",
		"<cmd>Lspsaga finder<CR>",
		vim.tbl_extend("force", bufopts, { desc = "Lspsaga: Finder" })
	)
	vim.keymap.set(
		"n",
		"<leader>rn",
		"<cmd>Lspsaga rename<CR>",
		vim.tbl_extend("force", bufopts, { desc = "Lspsaga: Rename" })
	)
end

return M
