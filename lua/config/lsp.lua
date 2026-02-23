vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = nil,
    },
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  root_markers = { ".git" },
})

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = { current_line = true },
  underline = true,
  update_in_insert = false,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "DiagnosticChanged" }, {
  group = vim.api.nvim_create_augroup("diagnostic_only_virtlines", {}),
  callback = function()
    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    local current_diag = vim.diagnostic.get(0, { lnum = lnum })
    if vim.tbl_isempty(current_diag) then
      vim.diagnostic.config({ virtual_text = true })
    else
      vim.diagnostic.config({ virtual_text = false })
    end
  end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
  group = vim.api.nvim_create_augroup("diagnostic_redraw", {}),
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    if mode == "v" or mode == "V" or mode == "\x16" then
      pcall(vim.diagnostic.enable, false)
    else
      pcall(vim.diagnostic.enable, true)
      pcall(vim.diagnostic.show)
    end
  end,
})

vim.lsp.enable("awkls")
vim.lsp.enable("basedpyright")
vim.lsp.enable("bashls")
vim.lsp.enable("clangd")
vim.lsp.enable("cssls")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("tailwindcss")
