return {
  'stevearc/conform.nvim',
  opts = {},
  config = function(_, opts)
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })

    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "autopep8" },
        rust = { "rustfmt" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
}
