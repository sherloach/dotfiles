local version = vim.version()
local header = {
  "                                                                    ",
  "            :h-                                  Nhy`               ",
  "           -mh.                           h.    `Ndho               ",
  "           hmh+                          oNm.   oNdhh               ",
  "          `Nmhd`                        /NNmd  /NNhhd               ",
  "          -NNhhy                      `hMNmmm`+NNdhhh               ",
  "          .NNmhhs              ```....`..-:/./mNdhhh+               ",
  "           mNNdhhh-     `.-::///+++////++//:--.`-/sd`               ",
  "           oNNNdhhdo..://++//++++++/+++//++///++/-.`                ",
  "      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:       ",
  " .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+        ",
  " h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`         ",
  " hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`        ",
  " /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.       ",
  "  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.      ",
  "   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.     ",
  "     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`    ",
  "       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:    ",
  "       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`   ",
  "       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:   ",
  "       //+++//++++++////+++///::--                 .::::-------::   ",
  "       :/++++///////////++++//////.                -:/:----::../-   ",
  "       -/++++//++///+//////////////               .::::---:::-.+`   ",
  "       `////////////////////////////:.            --::-----...-/    ",
  "        -///://////////////////////::::-..      :-:-:-..-::.`.+`    ",
  "         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -   ",
  "           ::::://::://::::::::::::::----------..-:....`.../- -+oo/ ",
  "            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``",
  "           s-`::--:::------:////----:---.-:::...-.....`./:          ",
  "          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`           ",
  "         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-              ",
  "        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`                ",
  "                        .-:mNdhh:.......--::::-`                    ",
  "                           yNh/..------..`                          ",
  "                                                                    ",
  "N E O V I M - v " .. version.major .. "." .. version.minor,
  "",
}

local center = {
  {
    desc = "Find File                     ",
    keymap = "",
    key = "f",
    icon = "  ",
    action = "Telescope find_files",
  },
  {
    desc = "Recents",
    keymap = "",
    key = "r",
    icon = "  ",
    action = "Telescope oldfiles",
  },
  {
    desc = "Browse Files",
    keymap = "",
    key = ".",
    icon = "  ",
    action = "Telescope file_browser",
  },
  {
    desc = "New File",
    keymap = "",
    key = "n",
    icon = "  ",
    action = "enew",
  },
  {
    desc = "Update Plugins",
    keymap = "",
    key = "u",
    icon = "  ",
    action = "Lazy update",
  },
  {
    desc = "Manage Extensions",
    keymap = "",
    key = "e",
    icon = "  ",
    action = "Mason",
  },
  {
    desc = "Config",
    keymap = "",
    key = "s",
    icon = "  ",
    action = "Telescope find_files cwd=~/.config/nvim",
  },
  {
    desc = "Exit",
    keymap = "",
    key = "q",
    icon = "  ",
    action = "exit",
  },
}

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "dashboard",
  group = vim.api.nvim_create_augroup("Dashboard_au", { clear = true }),
  callback = function()
    vim.cmd([[
            setlocal buftype=nofile
            setlocal nonumber norelativenumber nocursorline noruler
            nnoremap <buffer> <F2> :h news.txt<CR>
        ]])
  end,
})

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = "doom",
      config = {
        header = header,
        center = center,
        footer = function()
          return {
            "type  :help<Enter>  or  <F1>  for on-line help,  <F2>  news changelog",
            "Startup time: " .. require "lazy".stats().startuptime .. " ms"
          }
        end,
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
