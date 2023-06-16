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
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require("colorizer").setup({ "css", "scss", "html", "javascript", "typescript", "typescriptreact" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  { 'navarasu/onedark.nvim' },
  -- {
  --   'tjdevries/colorbuddy.nvim',
  --   event = "BufRead",
  --   config = function()
  --     local Color, colors, Group, groups, styles = require('colorbuddy').setup()

  --     Color.new('white', '#ffffff')
  --     Color.new('black', '#000000')
  --     Group.new('Normal', colors.base1, colors.NONE, styles.NONE)
  --     Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
  --     Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
  --     Group.new('Visual', colors.none, colors.base03, styles.reverse)

  --     local cError = groups.Error.fg
  --     local cInfo = groups.Information.fg
  --     local cWarn = groups.Warning.fg
  --     local cHint = groups.Hint.fg

  --     Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
  --     Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
  --     Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
  --     Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
  --     Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
  --     Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
  --     Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
  --     Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

  --     Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)
  --   end
  -- },
  -- {
  --   'svrana/neosolarized.nvim',
  --   config = function()
  --     require('neosolarized').setup {
  --       comment_italics = true,
  --     }
  --   end
  -- },
  {
    'marko-cerovac/material.nvim',
    config = function()
      require('material').setup({
        contrast = {
          terminal = false,            -- Enable contrast for the built-in terminal
          sidebars = false,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = false,    -- Enable contrast for floating windows
          cursor_line = false,         -- Enable darker background for the cursor line
          non_current_windows = false, -- Enable contrasted background for non-current windows
          filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
        },
        styles = {
          -- Give comments style such as bold, italic, underline etc.
          comments = { --[[ italic = true ]] },
          strings = { --[[ bold = true ]] },
          keywords = { --[[ underline = true ]] },
          functions = { --[[ bold = true, undercurl = true ]] },
          variables = {},
          operators = {},
          types = {},
        },
        plugins = { -- Uncomment the plugins that you use to highlight them
          -- Available plugins:
          -- "dap",
          -- "dashboard",
          "gitsigns",
          "hop",
          -- "indent-blankline",
          -- "lspsaga",
          -- "mini",
          -- "neogit",
          -- "neorg",
          "nvim-cmp",
          "nvim-navic",
          "nvim-tree",
          "nvim-web-devicons",
          -- "sneak",
          "telescope",
          -- "trouble",
          -- "which-key",
        },
        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false,        -- Disable borders between verticaly split windows
          background = false,     -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
          term_colors = false,    -- Prevent the theme from setting terminal colors
          eob_lines = false       -- Hide the end-of-buffer lines
        },
        high_visibility = {
          lighter = false,         -- Enable higher contrast text for lighter style
          darker = false           -- Enable higher contrast text for darker style
        },
        lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
        async_loading = true,      -- Load parts of the theme asyncronously for faster startup (turned on by default)
        custom_colors = nil,       -- If you want to everride the default colors, set this to a function
        custom_highlights = {
          -- NormalNC = { bg = 'NONE' }
        }, -- Overwrite highlights with your own
      })
    end
  }
}
