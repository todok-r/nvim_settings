local M = {}

-- Visualモードの選択範囲を取得する関数
function M.get_visual_selection()
	-- Visualモードの選択範囲の開始位置と終了位置を取得
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")

	-- 行と列のインデックスを取得
	local start_line = start_pos[2]
	local start_col = start_pos[3]
	local end_line = end_pos[2]
	local end_col = end_pos[3]

	-- 選択範囲内のテキストを取得
	local lines = vim.fn.getline(start_line, end_line)
	if #lines == 0 then
		return ""
	end

	-- 選択範囲が1行の場合
	if #lines == 1 then
		return string.sub(lines[1], start_col, end_col)
	end

	-- 選択範囲が複数行の場合
	lines[1] = string.sub(lines[1], start_col)
	lines[#lines] = string.sub(lines[#lines], 1, end_col)
	return table.concat(lines, "\n")
end

return M
