return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        colors = {
          -- add/modify theme and palette colors
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
              ui = {},
            },
          },
        },
        overrides = function(colors) -- add/modify highlights
          local theme = colors.theme
          return {
            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
            -- NormalFloat = { bg = "none" },
            -- FloatBorder = { bg = "none" },
            -- FloatTitle = { bg = "none" },
          }
        end,
        -- theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = {
          -- map the value of 'background' option to a theme
          dark = "wave", -- try "dragon" !
          light = "wave",
        },
      })
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    -- opts = function()
    --   return {
    --     transparent = true,
    --   }
    -- end,
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end, { silent = true, expr = true })

      vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end, { silent = true, expr = true })

      opts.presets.lsp_doc_border = true
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
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

      opts.config.header = header
    end,
  },
}
