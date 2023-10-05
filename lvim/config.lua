-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor at the middle of screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Prevent swaps line when hit esc and j/k at the same time
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

-- Fix Weird status line symbols (^)
vim.opt.fillchars = 'stl: '

lvim.colorscheme = "no-clown-fiesta"
-- vim.g.material_style = "deep ocean"

lvim.format_on_save.enabled = true

-- disable unused plugins
lvim.builtin.indentlines.active = false
lvim.builtin.lir.active = false
lvim.builtin.dap.active = false
lvim.builtin.illuminate.active = false

lvim.builtin.nvimtree.setup.view.side = 'right'

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
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
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
}

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
    strings = { italic = false },
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
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require('nvim-treesitter.configs').setup({
        autotag = {
          enable = true,
        }
      })
    end
  },
  { "marko-cerovac/material.nvim" },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    config = function()
      require("no-clown-fiesta").setup({
        transparent = false, -- Enable this to disable the bg color
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
    end,
  },
}
