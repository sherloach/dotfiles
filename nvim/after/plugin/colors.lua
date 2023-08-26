local colors = require('material.colors')

require('material').setup({
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
  } -- Overwrite highlights with your own
})

function ColorMyPencils(color) 
	color = color or "material"
	vim.g.material_style = "deep ocean"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
