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
