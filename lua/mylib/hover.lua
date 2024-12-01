M = {}

-- all functions are taken from share/nvim/runtime/lua/vim/lsp.lua of  v-0.11.0-dev-1257

--- This function is a copy of vim.lsp.buf_request_all with a timeout parameter.
--- The original buf_request_all waits for all clients to respond and if any of them
--- does not respond, the handler is not called.
--- This behavior prevents the hover popup from showing in some cases.
--- For example, in my config, tailwindcss-tools and typescript-tools run for 
--- a typescriptreact file.
--- When I edit a typescriptreact file which conains components with tailwindcss classes
--- and trying to hover over a class name, the hover popup does not show up.
--- It seems that this is caused by tsserver not responding to the hover request and
--- the callback handler of buf_request_all is not called.
--- To work around this, I added a timeout after which the handler is called.
--- FIXME: Maybe my config is wrong and this workaround is not needed.
--- When I have time, I will investigate this further.
local function buf_request_all_timeout(bufnr, method, params, handler, timeout)
	local results = {} --- @type table<integer,{err: lsp.ResponseError?, result: any}>
	local args = {}
	local remaining --- @type integer?
	local handler_called = false

	local _, cancel = vim.lsp.buf_request(bufnr, method, params, function(err, result, ctx, config)
		if not remaining then
			-- Calculate as late as possible in case a client is removed during the request
			remaining = #vim.lsp.get_clients({ bufnr = bufnr, method = method })
		end

		if not ctx then
			return
		end

		-- The error key is deprecated and will be removed in 0.13
		results[ctx.client_id] = { err = err, error = err, result = result }
		args[ctx.client_id] = { ctx = ctx, config = config }
		remaining = remaining - 1

		if remaining == 0 and not handler_called then
			handler_called = true
			handler(results, ctx, config)
		end
	end)

	local count = 0
	while true do
		if handler_called then
			break
		end

		if count > timeout then
			handler_called = true
			for client_id, _ in pairs(results) do
				handler(results, args[client_id].ctx, args[client_id].config)
				-- call for first client only
				break
			end

			break
		end
		count = count + 100
		vim.wait(100)
	end

	return cancel
end

local function client_positional_params(params)
	local win = vim.api.nvim_get_current_win()
	return function(client)
		local ret = vim.lsp.util.make_position_params(win, client.offset_encoding)
		if params then
			ret = vim.tbl_extend("force", ret, params)
		end
		return ret
	end
end

local ms = require("vim.lsp.protocol").Methods
local hover_ns = vim.api.nvim_create_namespace("vim_lsp_hover_range")
function M.hover(config)
	config = config or {}
	config.focus_id = ms.textDocument_hover

	buf_request_all_timeout(0, ms.textDocument_hover, client_positional_params(), function(results, ctx)
		local bufnr = assert(ctx.bufnr)
		if vim.api.nvim_get_current_buf() ~= bufnr then
			-- Ignore result since buffer changed. This happens for slow language servers.
			return
		end

		-- Filter errors from results
		local results1 = {} --- @type table<integer,lsp.Hover>

		for client_id, resp in pairs(results) do
			local err, result = resp.err, resp.result
			if err then
				vim.lsp.log.error(err.code, err.message)
			elseif result then
				results1[client_id] = result
			end
		end

		if vim.tbl_isempty(results1) then
			if config.silent ~= true then
				vim.notify("No information available")
			end
			return
		end

		local contents = {} --- @type string[]

		local nresults = #vim.tbl_keys(results1)

		local format = "markdown"

		for client_id, result in pairs(results1) do
			local client = assert(vim.lsp.get_client_by_id(client_id))
			if nresults > 1 then
				-- Show client name if there are multiple clients
				contents[#contents + 1] = string.format("# %s", client.name)
			end
			if type(result.contents) == "table" and result.contents.kind == "plaintext" then
				if #results1 == 1 then
					format = "plaintext"
					contents = vim.split(result.contents.value or "", "\n", { trimempty = true })
				else
					-- Surround plaintext with ``` to get correct formatting
					contents[#contents + 1] = "```"
					vim.list_extend(contents, vim.split(result.contents.value or "", "\n", { trimempty = true }))
					contents[#contents + 1] = "```"
				end
			else
				vim.list_extend(contents, vim.lsp.util.convert_input_to_markdown_lines(result.contents))
			end
			local range = result.range
			if range then
				local start = range.start
				local end_ = range["end"]
				local start_idx = vim.lsp.util._get_line_byte_from_position(bufnr, start, client.offset_encoding)
				local end_idx = vim.lsp.util._get_line_byte_from_position(bufnr, end_, client.offset_encoding)

				vim.hl.range(
					bufnr,
					hover_ns,
					"LspReferenceTarget",
					{ start.line, start_idx },
					{ end_.line, end_idx },
					{ priority = vim.hl.priorities.user }
				)
			end
			contents[#contents + 1] = "---"
		end

		-- Remove last linebreak ('---')
		contents[#contents] = nil

		if vim.tbl_isempty(contents) then
			if config.silent ~= true then
				vim.notify("No information available")
			end
			return
		end

		local _, winid = vim.lsp.util.open_floating_preview(contents, format, config)

		vim.api.nvim_create_autocmd("WinClosed", {
			pattern = tostring(winid),
			once = true,
			callback = function()
				vim.api.nvim_buf_clear_namespace(bufnr, hover_ns, 0, -1)
				return true
			end,
		})
	end, 500)
end

return M
