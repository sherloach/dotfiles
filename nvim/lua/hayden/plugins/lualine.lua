return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = '',
        component_separators = '',
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {
          {
            function()
              return " 󰀘 "
            end,
            padding = { left = 0, right = 0 },
            color = {},
            cond = nil,
          },
        },
        lualine_b = {
          {
            "b:gitsigns_head",
            icon = "%#SLGitIcon#" .. "" .. "%*" .. "%#SLBranchName#",
            color = { gui = "bold" },
          }
        },
        lualine_c = { 'filename' },
        lualine_x = {},
        lualine_y = { 'diagnostics' },
        lualine_z = { {'filesize', icon = "", color = { gui = "bold" }} }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end
}
