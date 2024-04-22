return {
  "VonHeikemen/lsp-zero.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(client, bufnr)
      -- Disable semantic tokens (lsp highlight). I dont like highlighting
      -- client.server_capabilities.semanticTokensProvider = nil

      local opts = { buffer = bufnr, remap = false }

      vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
      end, opts)
      vim.keymap.set("n", "gD", function()
        vim.lsp.buf.declaration()
      end, opts)
      vim.keymap.set("n", "gr", function()
        vim.lsp.buf.references()
      end, opts)
      vim.keymap.set("n", "gi", function()
        vim.lsp.buf.implementation()
      end, opts)
      vim.keymap.set("n", "gs", function()
        vim.lsp.buf.signature_help()
      end, opts)
      vim.keymap.set("n", "gl", function()
        local float = vim.diagnostic.config().float

        if float then
          local config = type(float) == "table" and float or {}
          config.scope = "line"

          vim.diagnostic.open_float(config)
        end
      end, opts)
      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
      end, opts)
      vim.keymap.set("n", "<leader>ws", function()
        vim.lsp.buf.workspace_symbol()
      end, opts)
      vim.keymap.set("n", "<leader>ca", function()
        vim.lsp.buf.code_action()
      end, opts)
      vim.keymap.set("n", "<leader>rr", function()
        vim.lsp.buf.references()
      end, opts)
      vim.keymap.set("n", "<leader>rn", function()
        require("hayden.conf.nui_lsp").lsp_rename()
      end, opts)
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
      end, opts)
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
      end, opts)
    end)

    lsp_zero.set_sign_icons({
      error = "󰅚",
      warn = "󰀪",
      hint = "󰌶",
      info = "",
    })

    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = { "tsserver", "rust_analyzer" },
      handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
          local lua_opts = lsp_zero.nvim_lua_ls()
          require("lspconfig").lua_ls.setup(lua_opts)
        end,
      },
    })

    local cmp = require("cmp")
    -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_window = require("cmp.config.window")

    require("luasnip.loaders.from_vscode").lazy_load()

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
    }

    cmp.setup({
      sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip", keyword_length = 2 },
        { name = "buffer",  keyword_length = 3 },
      },
      -- formatting = lsp_zero.cmp_format(),
      formatting = {
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
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.scroll_docs(-4),
        ["<C-n>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      window = {
        completion = cmp_window.bordered(),
        documentation = cmp_window.bordered(),
      },
    })

    vim.diagnostic.config({
      virtual_text = false, -- Disable inline diagnostics
      -- underline = true,
      -- signs = true,
      -- update_in_insert = false,
    })
  end,
}
