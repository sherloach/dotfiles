function ColorMyPencils(color)
    color = color or "kanagawa"
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#928374" })
end

ColorMyPencils()
