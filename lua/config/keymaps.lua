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
vim.api.nvim_set_keymap("n", "<leader>cd", ":cd %:p:h<CR>", { noremap = true, silent = true })

--Copilot
function M.setup_Copilot_keymaps()
	return {
		accept = "<M-l>",
		next = "<M-n>",
		prev = "<M-p>",
		dismiss = "M-]",
	}
end

--CopilotChat
function M.setup_CopilotChat_keymaps()
	return {
		{
			"<leader>cc",
			"<cmd>CopilotChat<cr>",
			{ desc = "open copilot chat window" },
		},
		{
			"<leader>cct",
			"<cmd>CopilotChatToggle<cr>",
			{ desc = "toggle copilot chat window" },
		},
		{
			"<leader>ccq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				local selection = require("mylib.utils").get_visual_selection()

				input = input .. " " .. selection .. "\n"

				if input ~= "" then
					require("CopilotChat").ask(input)
				end
			end,
			mode = "v",
			desc = "ask copilot chat about selected lines",
		},
		{
			"<leader>ccq",
			function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end,
			{ desc = "CopilotChat - Quick chat" },
		},
	}
end

--substitute
function M.setup_substitute_keymaps()
	return {
		{
			"s",
			function()
				require("substitute").operator()
			end,
			desc = "Substitute: Operator",
		},
		{
			"ss",
			function()
				require("substitute").line()
			end,
			desc = "Substitute: Line",
		},
		{
			"S",
			function()
				require("substitute").eol()
			end,
			desc = "Substitute: End of Line",
		},
		{
			"s",
			function()
				require("substitute").visual()
			end,
			mode = "x",
			desc = "Substitute: Visual",
		},
		{
			"<leader>s",
			function()
				require("substitute.range").operator()
			end,
			desc = "Substitute Range: Operator",
		},
		{
			"<leader>s",
			function()
				require("substitute.range").visual()
			end,
			mode = "x",
			desc = "Substitute Range: Visual",
		},
		{
			"<leader>ss",
			function()
				require("substitute.range").word()
			end,
			desc = "Substitute Range: Word",
		},
		{
			"sx",
			function()
				require("substitute.exchange").operator()
			end,
			desc = "Substitute Exchange: Operator",
		},
		{
			"sxx",
			function()
				require("substitute.exchange").line()
			end,
			desc = "Substitute Exchange: Line",
		},
		{
			"X",
			function()
				require("substitute.exchange").visual()
			end,
			mode = "x",
			desc = "Substitute Exchange: Visual",
		},
		{
			"sxc",
			function()
				require("substitute.exchange").cancel()
			end,
			desc = "Substitute Exchange: Cancel",
		},
	}
end

--neotest
function M.setup_neotest_keymaps()
	return {
		{
			"<leader>Ntr",
			function()
				require("neotest").run.run()
			end,
			mode = "n",
			desc = "run neotest",
		},
		{
			"<leader>Nts",
			function()
				require("neotest").run.stop()
			end,
			mode = "n",
			desc = "stop neotest",
		},
		{
			"<leader>Nto",
			function()
				require("neotest").output.open()
			end,
			mode = "n",
			desc = "output neotest",
		},
		{
			"<leader>Ntp",
			function()
				require("neotest").output_panel.toggle()
			end,
			mode = "n",
			desc = "toggle neotest",
		},
	}
end

--snippet
function M.setup_snippet_keymaps()
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
end

--undotree
vim.keymap.set({ "n" }, "<leader>ut", function()
	vim.cmd("UndotreeToggle")
end, { desc = "Toggle Undotree" })

--nvim-spectre
function M.setup_spectre_keymaps()
	return {
		{
			"<leader>St",
			function()
				require("spectre").toggle()
			end,
			desc = "Toggle Spectre",
		},
		{
			"<leader>Sw",
			function()
				require("spectre").open_visual({ select_word = true })
			end,
			desc = "Search current word",
		},
		{
			"<leader>Sw",
			function()
				require("spectre").open_visual()
			end,
			mode = "v",
			desc = "Search current word",
		},
		{
			"<leader>Sp",
			function()
				require("spectre").open_file_search({ select_word = true })
			end,
			desc = "Search on current file",
		},
	}
end

--nvim-tree
function M.setup_nvim_tree_keymaps()
	return {
		{
			"<leader>ntt",
			function()
				vim.cmd("NvimTreeToggle")
			end,
			desc = "Toggle NvimTree",
		},
		{
			"<leader>ntf",
			function()
				vim.cmd("NvimTreeFocus")
			end,
			desc = "Focus NvimTree",
		},
	}
end

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
function M.setup_dap_keymaps()
	return {
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "DAP: Continue",
		},
		{
			"<leader>dsv",
			function()
				require("dap").step_over()
			end,
			desc = "DAP: Step Over",
		},
		{
			"<leader>dsi",
			function()
				require("dap").step_into()
			end,
			desc = "DAP: Step Into",
		},
		{
			"<leader>dso",
			function()
				require("dap").step_out()
			end,
			desc = "DAP: Step Out",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "DAP: Toggle Breakpoint",
		},
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint()
			end,
			desc = "DAP: Set Breakpoint",
		},
		{
			"<leader>dlp",
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
			desc = "DAP: Log Point",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.open()
			end,
			desc = "DAP: REPL",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "DAP: Run Last",
		},
		{
			"<leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
			mode = { "n", "v" },
			desc = "DAP: Hover",
		},
		{
			"<leader>dp",
			function()
				require("dap.ui.widgets").preview()
			end,
			mode = { "n", "v" },
			desc = "DAP: Preview",
		},
		{
			"<leader>df",
			function()
				require("dap.ui.widgets").centered_float(widgets.frames)
			end,
			desc = "DAP: Frames",
		},
		{
			"<leader>dsc",
			function()
				require("dap.ui.widgets").centered_float(widgets.scopes)
			end,
			desc = "DAP: Scopes",
		},
	}
end

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
function M.setup_todo_comments_keymaps()
	return {
		{
			"<leader>tcl",
			"<cmd>TodoLocList<CR>",
			desc = "show todo list",
		},
		{
			"<leader>tcq",
			"<cmd>TodoQuickFix<CR>",
			desc = "show todo quickfix",
		},
		{
			"<leader>tcn",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},
		{
			"<leader>tcp",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous todo comment",
		},
	}
end

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
		--vim.lsp.buf.definition,
		"<cmd>Lspsaga goto_definition<CR>",
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
	--	vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
	vim.keymap.set("n", "<leader>K", require("mylib.hover").hover, { desc = "mylib.hover" })
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
	vim.keymap.set("n", "gK", function()
		require("hover").hover_select()
	end, { desc = "hover.nvim (select)" })
end

--minty
vim.keymap.set("n", "<leader>mh", "<cmd>lua require('minty.huefy').open()<CR>", { desc = "open minty huefy" })
vim.keymap.set("n", "<leader>ms", "<cmd>lua require('minty.shades').open()<CR>", { desc = "open minty shades" })

--harpoon
function M.setup_harpoon_keymaps()
	local harpoon = require("harpoon")

	vim.keymap.set("n", "<leader>ha", function()
		harpoon:list():add()
	end, { desc = "Add current buffer to Harpoon" })
	vim.keymap.set("n", "<leader>hl", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = "Toggle Harpoon list" })

	vim.keymap.set("n", "<leader>h1", function()
		harpoon:list():select(1)
	end, { desc = "Select Harpoon list 1" })
	vim.keymap.set("n", "<leader>h2", function()
		harpoon:list():select(2)
	end, { desc = "Select Harpoon list 2" })
	vim.keymap.set("n", "<leader>h3", function()
		harpoon:list():select(3)
	end, { desc = "Select Harpoon list 3" })
	vim.keymap.set("n", "<leader>h4", function()
		harpoon:list():select(4)
	end, { desc = "Select Harpoon list 4" })

	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set("n", "<leader>hp", function()
		harpoon:list():prev()
	end, { desc = "Harpoon: Previous" })
	vim.keymap.set("n", "<leader>hn", function()
		harpoon:list():next()
	end, { desc = "Harpoon: Next" })
end

-- nvim-treesitter-context
vim.keymap.set("n", "<leader>tsct", "<cmd>TSContextToggle<CR>", { desc = "nvim-treesitter-context toggle" })

-- trouble
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xX",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

--which
vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

--Telescope
function M.setup_telescope_keymaps()
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
	vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
	vim.keymap.set("n", "<leader>ft", "<cmd>Telescope<cr>", { desc = "Telescope" })

	local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
	vim.keymap.set("n", "<leader>fG", live_grep_args_shortcuts.grep_word_under_cursor, { desc = "grep under cursor" })
	vim.keymap.set(
		"x",
		"<leader>fv",
		live_grep_args_shortcuts.grep_visual_selection,
		{ desc = "grep visual selection" }
	)
end

--kulala
function M.setup_kulala_keymaps()
	vim.keymap.set(
		"n",
		"<leader>ks",
		"<cmd>lua require('kulala').scratchpad()<cr>",
		{ noremap = true, silent = true, buffer = true }
	)
	vim.keymap.set(
		"n",
		"<leader>kr",
		"<cmd>lua require('kulala').run()<cr>",
		{ noremap = true, silent = true, buffer = true }
	)
	vim.keymap.set(
		"n",
		"<leader>kp",
		"<cmd>lua require('kulala').jump_prev()<cr>",
		{ noremap = true, silent = true, buffer = true }
	)
	vim.keymap.set(
		"n",
		"<leader>kn",
		"<cmd>lua require('kulala').jump_next()<cr>",
		{ noremap = true, silent = true, buffer = true }
	)
end

-- vim-dad-bod
function M.setup_dadbod_keymaps()
	vim.keymap.set("n", "<leader>db", ":DB<cr>", { desc = "run dadbod", noremap = true, silent = true, buffer = true })
	vim.keymap.set("x", "<leader>db", ":DB<cr>", { desc = "run dadbod", noremap = true, silent = true, buffer = true })
end

-- gitsigns
function M.setup_gitsigns_keymaps(bufnr)
	local gitsigns = require("gitsigns")

	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	map("n", "]c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gitsigns.nav_hunk("next")
		end
	end, { desc = "gitsigns.nav_hunk_next" })

	map("n", "[c", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gitsigns.nav_hunk("prev")
		end
	end, { desc = "gitsigns.nav_hunk_prev" })

	-- Actions
	map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "gitsigns.stage_hunk" })
	map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "gitsigns.reset_hunk" })

	map("v", "<leader>hs", function()
		gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "gitsigns.stage_hunk" })

	map("v", "<leader>hr", function()
		gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
	end, { desc = "gitsigns.reset_hunk" })

	map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "gitsigns.stage_buffer" })
	map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "gitsigns.reset_buffer" })
	map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "gitsigns.preview_hunk" })
	map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "gitsigns.preview_hunk_inline" })

	map("n", "<leader>hb", function()
		gitsigns.blame_line({ full = true })
	end, { desc = "gitsigns.blame_line" })

	map("n", "<leader>hd", gitsigns.diffthis, { desc = "gitsigns.diffthis" })

	map("n", "<leader>hD", function()
		gitsigns.diffthis("~")
	end, { desc = "gitsigns.diffthis_tilde" })

	map("n", "<leader>hQ", function()
		gitsigns.setqflist("all")
	end, { desc = "gitsigns.setqflist_all" })
	map("n", "<leader>hq", gitsigns.setqflist, { desc = "gitsigns.setqflist" })

	-- Toggles
	map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "gitsigns.toggle_current_line_blame" })
	map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "gitsigns.toggle_deleted" })
	map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "gitsigns.toggle_word_diff" })

	-- Text object
	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "gitsigns.select_hunk" })
end

--diffview
vim.keymap.set("n", "<leader>dvo", "<cmd>DiffviewOpen<cr>", { desc = "DiffviewOpen" })
vim.keymap.set("n", "<leader>dvc", "<cmd>DiffviewClose<cr>", { desc = "DiffviewClose" })
vim.keymap.set("n", "<leader>dvh", "<cmd>DiffviewFileHistory<cr>", { desc = "DiffviewFileHistory" })
vim.keymap.set("n", "<leader>dvH", "<cmd>DiffviewFileHistory %<cr>", { desc = "DiffviewFileHistory current file" })
vim.keymap.set("n", "<leader>dvt", "<cmd>DiffviewToggleFiles<cr>", { desc = "DiffviewToggleFiles" })
vim.keymap.set("n", "<leader>dvf", "<cmd>DiffviewFocusFiles<cr>", { desc = "DiffviewFocusFiles" })

return M
