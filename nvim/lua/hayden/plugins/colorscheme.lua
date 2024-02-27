return {
    -- {
    --     "aktersnurra/no-clown-fiesta.nvim",
    --     lazy = false,
    --     config = function()
    --         require("no-clown-fiesta").setup({
    --             transparent = false, -- Enable this to disable the bg color
    --             styles = {
    --                 -- You can set any of the style values specified for `:h nvim_set_hl`
    --                 comments = {},
    --                 keywords = {},
    --                 functions = {},
    --                 variables = {},
    --                 type = { bold = true },
    --                 lsp = { underline = true }
    --             },
    --         })
    --     end,
    -- },
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_background = 'hard'
            -- vim.g.gruvbox_material_better_performance = true
            -- vim.g.gruvbox_material_diagnostic_text_highlight = true
            -- vim.g.gruvbox_material_transparent_background = 2
            -- vim.cmd [[let g:gruvbox_material_foreground = 'mix']]
            -- vim.cmd [[let g:gruvbox_material_diagnostic_virtual_text = 'colored']]
            -- vim.cmd([[colorscheme gruvbox-material]])

            -- function ColorMyPencils(color)
            --     color = color or "gruvbox-material"
            --     vim.cmd.colorscheme(color)
            --
            --     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            --     vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#928374" })
            -- end
            --
            -- ColorMyPencils()
        end,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('kanagawa').setup({
                compile = false,  -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = { italic = false },
                keywordStyle = { italic = false },
                statementStyle = { bold = true },
                typeStyle = { italic = false },
                transparent = true,   -- do not set background color
                dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = {
                    -- add/modify theme and palette colors
                    palette = {},
                    theme = {
                        wave = {},
                        lotus = {},
                        dragon = {},
                        all = {
                            ui = {}
                        }
                    },
                },
                overrides = function(colors) -- add/modify highlights
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },
                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        -- Completion (Popup) menu
                        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                        PmenuSbar = { bg = theme.ui.bg_m1 },
                        PmenuThumb = { bg = theme.ui.bg_p2 },
                    }
                end,
                theme = "wave", -- Load "wave" theme when 'background' option is not set
                background = {
                    -- map the value of 'background' option to a theme
                    dark = "wave", -- try "dragon" !
                    light = "lotus"
                },
            })
        end
    },
    -- {
    --     "embark-theme/vim",
    --     as = "embark",
    -- },
}
