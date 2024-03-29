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

-- lvim.colorscheme = "gruvbox-material"
-- vim.g.gruvbox_material_background = 'hard'
-- vim.g.material_style = "deep ocean"

lvim.format_on_save.enabled = true

-- disable unused plugins
lvim.builtin.indentlines.active = false
lvim.builtin.lir.active = false
lvim.builtin.dap.active = false
lvim.builtin.illuminate.active = false
lvim.builtin.breadcrumbs.active = false
lvim.transparent_window = true

lvim.builtin.nvimtree.setup.view.side = 'right'
-- lvim.builtin.lualine.sections.lualine_z = {
--   {
--     'vim.fn["codeium#GetStatusString"]()',
--     fmt = function(str)
--       return "{…}:" .. str:match("^%s*(.-)%s*$")
--     end
--   }
-- }

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

-- local colors = require('material.colors')
-- require('material').setup({
--   contrast = {
--     terminal = false,            -- Enable contrast for the built-in terminal
--     sidebars = false,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
--     floating_windows = false,    -- Enable contrast for floating windows
--     cursor_line = false,         -- Enable darker background for the cursor line
--     non_current_windows = false, -- Enable contrasted background for non-current windows
--     filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
--   },
--   styles = {
--     -- Give comments style such as bold, italic, underline etc.
--     comments = { italic = true },
--     strings = { italic = false },
--     keywords = { italic = true },
--     functions = { italic = true },
--     variables = { italic = false },
--     operators = {},
--     types = { italic = true },
--   },
--   plugins = { -- Uncomment the plugins that you use to highlight them
--     -- Available plugins:
--     -- "dap",
--     -- "dashboard",
--     "gitsigns",
--     "hop",
--     "indent-blankline",
--     -- "lspsaga",
--     -- "mini",
--     -- "neogit",
--     -- "neorg",
--     "nvim-cmp",
--     "nvim-navic",
--     "nvim-tree",
--     "nvim-web-devicons",
--     -- "sneak",
--     "telescope",
--     -- "trouble",
--     -- "which-key",
--   },
--   disale = {
--     colored_cursor = false, -- Disable the colored cursor
--     borders = false,        -- Disable borders between verticaly split windows
--     background = true,      -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
--     term_colors = false,    -- Prevent the theme from setting terminal colors
--     eob_lines = false       -- Hide the end-of-buffer lines
--   },
--   high_visibility = {
--     lighter = false,         -- Enable higher contrast text for lighter style
--     darker = false           -- Enable higher contrast text for darker style
--   },
--   lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
--   async_loading = true,      -- Load parts of the theme asyncronously for faster startup (turned on by default)
--   custom_colors = nil,       -- If you want to everride the default colors, set this to a function
--   custom_highlights = {
--     ['@keyword'] = {
--       fg = colors.main.cyan,
--       italic = true
--     },
--     ['@include'] = {
--       fg = colors.main.cyan,
--       italic = true
--     }
--     -- NormalNC = { bg = 'NONE' }
--   }, -- Overwrite highlights with your own
-- })


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
          functions = { bold = true },
          variables = {},
          type = { bold = true },
          lsp = { underline = true }
        },
      })
    end,
  },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
  },
  {
    "2nthony/vitesse.nvim",
    dependencies = {
      "tjdevries/colorbuddy.nvim"
    },
    config = function()
      require('vitesse').setup({
        comment_italics = true,
        transparent_background = false,
        transparent_float_background = false, -- aka pum(popup menu) background
        reverse_visual = false,
        dim_nc = false,
        cmp_cmdline_disable_search_highlight_group = false, -- disable search highlight group for cmp item
        -- if `transparent_float_background` false, make telescope border color same as float background
        telescope_border_follow_float_background = false,
        -- diagnostic virtual text background, like error lens
        diagnostic_virtual_text_background = false,

        -- override the `lua/vitesse/palette.lua`, go to file see fields
        colors = {},
        themes = {
          background = '#000000', -- override background
        },
      })
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("solarized-osaka").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        transparent = false,    -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",              -- style for sidebars, see below
          floats = "dark",                -- style for floating windows
        },
        sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false,             -- dims inactive windows
        lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      })
    end
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
  },
  {
    "b0o/incline.nvim",
    config = function()
      local function get_diagnostic_label(props)
        local icons = {
          Error = "",
          Warn = "",
          Info = "",
          Hint = "",
        }

        local label = {}
        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            local fg = "#" ..
                string.format("%06x", vim.api.nvim_get_hl_by_name("DiagnosticSign" .. severity, true)["foreground"])
            table.insert(label, { icon .. " " .. n .. " ", guifg = fg })
          end
        end
        return label
      end


      require('incline').setup {
        debounce_threshold = {
          falling = 50,
          rising = 10
        },
        hide = {
          cursorline = false,
          focused_win = false,
          only_win = false
        },
        highlight = {
          groups = {
            InclineNormal = {
              default = true,
              group = "NormalFloat"
            },
            InclineNormalNC = {
              default = true,
              group = "NormalFloat"
            }
          }
        },
        ignore = {
          buftypes = "special",
          filetypes = {},
          floating_wins = true,
          unlisted_buffers = true,
          wintypes = "special"
        },
        -- render = "basic",
        render = function(props)
          local bufname = vim.api.nvim_buf_get_name(props.buf)
          local filename = vim.fn.fnamemodify(bufname, ":t")
          local diagnostics = get_diagnostic_label(props)
          local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "None"
          local filetype_icon, color = require("nvim-web-devicons").get_icon_color(filename)

          local buffer = {
            { filetype_icon, guifg = color },
            { " " },
            { filename,      gui = modified },
          }

          if #diagnostics > 0 then
            table.insert(diagnostics, { "| ", guifg = "grey" })
          end
          for _, buffer_ in ipairs(buffer) do
            table.insert(diagnostics, buffer_)
          end
          return diagnostics
        end,
        window = {
          margin = {
            horizontal = 1,
            vertical = 1
          },
          options = {
            signcolumn = "no",
            wrap = false
          },
          padding = 1,
          padding_char = " ",
          placement = {
            horizontal = "right",
            vertical = "top"
          },
          width = "fit",
          winhighlight = {
            active = {
              EndOfBuffer = "None",
              Normal = "InclineNormal",
              Search = "None"
            },
            inactive = {
              EndOfBuffer = "None",
              Normal = "InclineNormalNC",
              Search = "None"
            }
          },
          zindex = 50
        }
      }
    end
  }
}
