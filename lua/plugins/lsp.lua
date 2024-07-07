return {
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"clangd",
					"cssls",
					"eslint",
					"html",
					"jsonls",
					"lua_ls",
					"pyright",
					--'ruff',
					"tsserver",
					"vimls",
				},
				handlers = {
					lsp_zero.default_setup,
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"clang-format",
					"eslint",
					"jsonlint",
					"lua-formatter",
					"prettier",
					"stylua",
				},
				automatic_installation = true, -- You can still set this to `true`
				handlers = {
				},
			})
			--[[
			local status, null_ls = pcall(require, "none-ls")
			if not status then
				return
			end

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
				},
			})
			]]
		end,
	},
	{
		"onsails/lspkind.nvim",
		config = function()
			require("lspkind").init({
				-- DEPRECATED (use mode instead): enables text annotations
				--
				-- default: true
				-- with_text = true,

				-- defines how annotations are shown
				-- default: symbol
				-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
				mode = "symbol_text",

				-- default symbol map
				-- can be either 'default' (requires nerd-fonts font) or
				-- 'codicons' for codicon preset (requires vscode-codicons font)
				--
				-- default: 'default'
				preset = "codicons",

				-- override preset symbols
				--
				-- default: {}
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",
					Field = "󰜢",
					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",
					Unit = "󰑭",
					Value = "󰎠",
					Enum = "",
					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",
					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		--		commit = "a17c975ac2eaa96736458d0a2cdd6abeb8f7811f",
		commit = "6f920cf",
		config = function()
			require("lspsaga").setup({
				code_action = {
					extend_gitsigns = true,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{ "kosayoda/nvim-lightbulb" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.setup()

			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				lsp_zero.default_keymaps({ buffer = bufnr })
				vim.keymap.set("n", "<leader><C-k>", vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
				--	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "<leader>gq", vim.lsp.buf.format, bufopts)
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, bufopts)
				--vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
				vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, bufopts)
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, bufopts)
				vim.keymap.set("n", "<leader>gI", "<cmd>Lspsaga peek_definition<CR>", bufopts)
				--vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, bufopts)
				vim.keymap.set("n", "]g", vim.diagnostic.goto_next, bufopts)

				vim.keymap.set("v", "<leader>gq", vim.lsp.buf.format, bufopts)

				vim.keymap.set("n", "K", "<cmd>Lspsaga hover<CR>", bufopts)
				vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", bufopts)
				vim.keymap.set("n", "[G", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
				vim.keymap.set("n", "]G", "cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
				vim.keymap.set("n", "]G", "cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
				vim.keymap.set("n", "<leader>F", "<cmd>Lspsaga finder<CR>", bufopts)
				vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", bufopts)
			end)

			lsp_zero.set_server_config({
				on_init = function(client)
					--		client.server_capabilities.semanticTokensProvider = nil
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentFormattingRangeProvider = false
				end,
			})
		end,
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
}
