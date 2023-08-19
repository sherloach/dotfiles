-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.transparent_window = false
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- Additional plugin config
vim.g.blamer_enabled = 1
vim.g.blamer_delay = 500
vim.g.blamer_show_in_visual_modes = 0

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping

-- Prevent swaps line when hit esc and j/k at the same time
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
-- lvim.builtin.indentlines.active = false

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
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  }
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    exe = "eslint_d",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" },
  },
}

-- lvim.autocommands = {
--   -- other commands,
--   {
--     "ColorScheme",
--     { command = "hi NvimTreeNormalNC guibg=NONE" },
--   }
-- }

require('ayu').setup({
  mirage = false,
  overrides = {
    Constant = { fg = '#D2A6FF' }
  }
})

lvim.colorscheme = "material"
vim.g.material_style = "deep ocean"
local colors = require('material.colors')
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
    comments = { italic = true },
    strings = { italic = true },
    keywords = { italic = true },
    functions = { italic = true },
    variables = { italic = false },
    operators = {},
    types = { italic = true },
  },
  plugins = { -- Uncomment the plugins that you use to highlight them
    -- Available plugins:
    -- "dap",
    -- "dashboard",
    "gitsigns",
    "hop",
    "indent-blankline",
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
  disale = {
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
    ['@keyword'] = {
      fg = colors.main.cyan,
      italic = true
    },
    ['@include'] = {
      fg = colors.main.cyan,
      italic = true
    }
    -- NormalNC = { bg = 'NONE' }
  }, -- Overwrite highlights with your own
})

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
  { 'marko-cerovac/material.nvim' },
  { 'shatur/neovim-ayu' },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-treesitter.configs').setup({
        autotag = {
          enable = true,
        }
      })
    end
  },
  {
    'abecodes/tabout.nvim',
    config = function()
      require('tabout').setup {
        tabkey = '<Tab>',             -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true,            -- shift content if tab out is not possible
        act_as_shift_tab = false,     -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = '<C-t>',        -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = '<C-d>',  -- reverse shift default action,
        enable_backwards = true,      -- well ...
        completion = true,            -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = '`', close = '`' },
          { open = '(', close = ')' },
          { open = '[', close = ']' },
          { open = '{', close = '}' }
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {} -- tabout will ignore these filetypes
      }
    end,
    wants = { 'nvim-treesitter' }, -- or require if not used so far
    after = { 'nvim-cmp' }         -- if a completion plugin is using tabs load it before
  }
}
