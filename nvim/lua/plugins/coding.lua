return {
  {
    cmd = "Codeium",
    "Exafunction/codeium.nvim",
    build = ":Codeium Auth",
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          src = {
            cmp = { enabled = true },
          },
        },
      },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local cmp_window = require("cmp.config.window")

      local M = {}

      M.icons = {
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Enum = " ",
        EnumMember = " ",
        Field = "󰄶 ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = "󰜰",
        Keyword = "󰌆 ",
        Method = "ƒ ",
        Module = "󰏗 ",
        Property = " ",
        Snippet = "󰘍 ",
        Struct = " ",
        Text = " ",
        Unit = " ",
        Value = "󰎠 ",
        Variable = " ",
        Codeium = "",
      }

      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = "crates" })

      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local maxwidth = 50
          local n = entry.source.name

          if n == "nvim_lsp" then
            vim_item.menu = "[LSP]"
          elseif n == "nvim_lua" then
            vim_item.menu = "[nvim]"
          else
            vim_item.menu = string.format("[%s]", n)
          end

          if maxwidth and #vim_item.abbr > maxwidth then
            local last = vim_item.kind == "Snippet" and "~" or ""
            vim_item.abbr = string.format("%s %s", string.sub(vim_item.abbr, 1, maxwidth), last)
          end
          vim_item.kind = M.icons[vim_item.kind]

          return vim_item
        end,
      }

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.scroll_docs(-4),
        ["<C-n>"] = cmp.mapping.scroll_docs(4),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = function()
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            cmp.complete()
          end
        end,
        ["<C-c>"] = cmp.mapping.abort(),
      })

      opts.window = {
        completion = cmp_window.bordered(),
        documentation = cmp_window.bordered(),
      }
    end,
  },
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },
  {
    "echasnovski/mini.surround",
    enabled = false,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
        -- Usage:
        -- surr*ound_words             ysiw)           (surround_words)
        -- *make strings               ys$"            "make strings"
        -- [delete ar*ound me!]        ds]             delete around me!
        -- remove <b>HTML t*ags</b>    dst             remove HTML tags
        -- 'change quot*es'            cs'"            "change quotes"
        -- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
        -- delete(functi*on calls)     dsf             function calls
      })
    end,
  },
}
