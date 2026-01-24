return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- run ruff as lsp
        -- python = { "ruff" },
        json = { "jsonlint" },
        typescript = { "eslint" },
        javascript = { "eslint" },
        toml = { "tombi" },
      }
      -- 保存時に診断を実行
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
