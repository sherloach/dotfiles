-- Additional Plugins
lvim.plugins = {
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  { 'APZelos/blamer.nvim' },
  { 'norcalli/nvim-colorizer.lua' },
  { 'navarasu/onedark.nvim' },
  {
    'tjdevries/colorbuddy.nvim',
    event = "BufRead",
    config = function()
      local Color, colors, Group, groups, styles = require('colorbuddy').setup()

      Color.new('white', '#ffffff')
      Color.new('black', '#000000')
      Group.new('Normal', colors.base1, colors.NONE, styles.NONE)
      Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
      Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
      Group.new('Visual', colors.none, colors.base03, styles.reverse)

      local cError = groups.Error.fg
      local cInfo = groups.Information.fg
      local cWarn = groups.Warning.fg
      local cHint = groups.Hint.fg

      Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
      Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
      Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
      Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

      Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)
    end
  },
  {
    'svrana/neosolarized.nvim',
    config = function()
      require('neosolarized').setup {
        comment_italics = true,
      }
    end
  }
}
