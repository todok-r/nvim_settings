--return {}

return {
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
	opts = {
		ensure_installed = {
			'bash', 'comment', 'css', 'diff', 'dockerfile', 'fennel', 'fish',
			'gitcommit', 'gitignore', 'gitattributes', 'git_rebase', 'go', 'gomod',
			'gosum', 'gowork', 'graphql', 'hcl', 'html', 'javascript', 'jsdoc',
			'json', 'json5', 'jsonc', 'jsonnet', 'lua', 'make', 'markdown',
			'markdown_inline', 'nix', 'perl', 'php', 'pug', 'python', 'regex',
			'rst', 'ruby', 'rust', 'scss', 'sql', 'svelte', 'terraform', 'toml',
			'tsx', 'typescript', 'vim', 'vimdoc', 'vue', 'vim', 'vimdoc', 'yaml', 'zig',
		},
	},
},
{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
{'windwp/nvim-ts-autotag',
opts = {
	-- Defaults
	enable_close = true, -- Auto close tags
	enable_rename = true, -- Auto rename pairs of tags
	enable_close_on_slash = false -- Auto close on trailing </
},
-- Also override individual filetype configs, these take priority.
-- Empty by default, useful if one of the "opts" global settings
-- doesn't work well in a specific filetype
per_filetype = {
	["html"] = {
		enable_close = false
	}
}
}
}
