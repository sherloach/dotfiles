return {
  "aktersnurra/no-clown-fiesta.nvim",
  lazy = false,
  config = function()
    require("no-clown-fiesta").setup({
      transparent = false,   -- Enable this to disable the bg color
      styles = {
        -- You can set any of the style values specified for `:h nvim_set_hl`
        comments = {},
        keywords = {},
        functions = {},
        variables = {},
        type = { bold = true },
        lsp = { underline = true }
      },
    })
    vim.cmd([[colorscheme no-clown-fiesta]])
  end,
}
