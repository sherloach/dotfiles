function ColorMyPencils(color)
  color = color or "kanagawa"
  vim.cmd.colorscheme(color)

  -- snippet to automatically change the theme for the Kitty terminal emulator.
  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "kanagawa",
    callback = function()
      if vim.o.background == "light" then
        vim.fn.system("kitty +kitten themes Kanagawa_light")
      elseif vim.o.background == "dark" then
        vim.fn.system("kitty +kitten themes Kanagawa")
      else
        vim.fn.system("kitty +kitten themes Kanagawa_dragon")
      end
    end,
  })

  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#928374" })
end

ColorMyPencils()
