return {
  {
    "stevearc/conform.nvim",
    --    event = { "BufWritePre" },
    --    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        json = { "jq" },
        lua = { "stylua" },
        python = { "ruff_format", "ruff_check", "ruff_organize_imports" },
        sh = { "shfmt" },
        javascript = { "prettier", stop_after_first = true },
        typescript = { "prettier", stop_after_first = true },
        toml = { "tombi" },
      },
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_format = "fallback",
      -- },
    },
  },
}
