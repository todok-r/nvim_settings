return {
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ensure_installed = {
					"tailwindcss-language-server",
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.setup()
			lsp_zero.extend_lspconfig()

			lsp_zero.set_server_config({
				on_init = function(client)
					if client.name == "ruff" then
						-- ruff runs as formatter and linter
						client.server_capabilities.semanticTokensProvider = nil
						client.server_capabilities.hoverProvider = false
					else
						client.server_capabilities.semanticTokensProvider = nil
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentFormattingRangeProvider = false
					end
				end,
			})

			-- mason-lspconfig
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"clangd",
					"cssls",
					--"eslint",
					"html",
					"jsonls",
					"lua_ls",
					"basedpyright",
					"ruff",
					-- "tsserver",
					"vimls",
				},
				automatic_installation = true,
				handlers = {
					lsp_zero.default_setup,
				},
			})

			-- none-ls
			local status, null_ls = pcall(require, "null-ls")
			if not status then
				print("none-ls not found")
				return
			end
			local null_ls_opts = lsp_zero.build_options("null-ls", {})

			null_ls.setup({
				on_attach = function(client, bufnr)
					--print("null-ls attach", client.id, bufnr)
					null_ls_opts.on_attach(client, bufnr)
				end,
				sources = {
					--typescript
					--require("none-ls.diagnostics.eslint_d"),
					require("none-ls.diagnostics.eslint"),
					--require("none-ls.code_actions.eslint"),
					--null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.prettier,

					--python
					--require("none-ls.formatting.ruff"),
					--require("none-ls.diagnostics.ruff"),
					--null_ls.builtins.formatting.black,

					--lua
					null_ls.builtins.formatting.stylua,

					--shell
					null_ls.builtins.formatting.shfmt,
					--null_ls.builtins.formatting.shellharden,
				},
			})

			-- mason-null-ls
			require("mason-null-ls").setup({
				--ensure_installed = nil,
				ensure_installed = {
					--"black",
					--"clang-format",
					--"eslint_d",
					"jsonlint",
					--"lua-formatter",
					--"prettierd",
					"prettier",
					--"ruff",
					"shfmt",
					--"shellharden",
					"shellcheck",
					"stylua",
				},
				automatic_installation = true, -- You can still set this to `true`
				--handlers = { },
			})

			lsp_zero.on_attach(function(_, bufnr)
				--print("lsp-zero attach", client.id, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				--[[
				if vim.lsp.buf_attach_client(bufnr, client.id) then
					print("succeed")
				else
					print("fail")
				end
				print(vim.inspect(vim.lsp.get_buffers_by_client_id(client.id)))
				--print(vim.inspect(client))
				]]

				require("config.keymaps").lsp_keymaps(bufnr)
			end)
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
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
	-- { "kosayoda/nvim-lightbulb" },
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
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
}
