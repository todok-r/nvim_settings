local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("python", {
	s("if __", {
		t({ 'if __name__ == "__main__":', "    pass" }),
	}),
})
