return {
  "stevearc/conform.nvim",
  opts = {},
  config = function(_, opts)
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf, lsp_fallback = true })
      end,
    })

    require("conform").setup({
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        -- lua = { "stylua" },
        python = { "autopep8" },
        -- rust = { "rustfmt" },

        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
      formatters = {
        -- stylua = {
        --   -- args = { "--indent-type", "Spaces", "--indent-width", "4" }
        --   args = { "--config-path=" .. vim.env.HOME .. "/.config/stylua.toml" },
        -- },
      },
    })

    -- local conform = require("conform")
    -- conform.formatters.stylua = {
    --   args = { "--config-path=" .. vim.env.HOME .. "/.config/stylua.toml" },
    -- }
  end,
}
