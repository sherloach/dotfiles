return {
    {
        "aktersnurra/no-clown-fiesta.nvim",
        lazy = false,
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
    {
        "sainnhe/gruvbox-material",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_better_performance = true
            vim.g.gruvbox_material_transparent_background = 2
            vim.cmd([[colorscheme gruvbox-material]])

            function ColorMyPencils(color)
                color = color or "gruvbox-material"
                vim.cmd.colorscheme(color)

                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end

            ColorMyPencils()
        end,
    }
}
