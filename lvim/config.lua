-- -- base
-- require('base.general')
-- -- keys
-- require('keys.main')           -- Keys for built-in features
-- -- plugins
-- require('plugins.core.config') -- Configs for built-in plugins
-- require('plugins.packer.plugins')

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "material-deep-ocean"
lvim.transparent_window = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.indentlines.active = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
  {
    command = "eslint_d",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "python" },
  }
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    exe = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
  },
}

-- lvim.builtin.lualine.options.theme = "solarized_dark"
-- lvim.builtin.lualine.options.section_separators = { left = '', right = '' }
-- lvim.builtin.lualine.options.component_separators = { left = '', right = '' }

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
          background = true,      -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
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
