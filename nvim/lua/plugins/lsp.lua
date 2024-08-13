return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "<leader>cc", false }
      keys[#keys + 1] = {
        "gl",
        function()
          vim.diagnostic.config({
            float = { border = "rounded" },
          })
          local float = vim.diagnostic.config().float

          if float then
            local config = type(float) == "table" and float or {}
            config.scope = "line"

            vim.diagnostic.open_float(config)
          end
        end,
        desc = "Line Diagnostics",
      }
    end,
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        rust_analyzer = {},
        taplo = {
          keys = {
            {
              "K",
              function()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = {},
          -- to fully override the default_config, change the below
          -- filetypes = {}
        },
        -- Swift
        sourcekit = {
          cmd = {
            "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
          },
        },
      },
      setup = {
        rust_analyzer = function()
          return true
        end,
        tailwindcss = function(_, opts)
          local tw = require("lspconfig.server_configurations.tailwindcss")
          opts.filetypes = opts.filetypes or {}

          -- Add default filetypes
          vim.list_extend(opts.filetypes, tw.default_config.filetypes)

          -- Remove excluded filetypes
          --- @param ft string
          opts.filetypes = vim.tbl_filter(function(ft)
            return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
          end, opts.filetypes)

          -- Additional settings for Phoenix projects
          opts.settings = {
            tailwindCSS = {
              includeLanguages = {
                elixir = "html-eex",
                eelixir = "html-eex",
                heex = "html-eex",
              },
            },
          }

          -- Add additional filetypes
          vim.list_extend(opts.filetypes, opts.filetypes_include or {})
        end,
      },
    },
    config = function()
      -- Swift LSP setup for file with 'swift' extension
      -- https://chrishannah.me/using-a-swift-lsp-in-neovim/
      local swift_lsp = vim.api.nvim_create_augroup("swift_lsp", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "swift" },
        callback = function()
          local root_dir = vim.fs.dirname(vim.fs.find({
            "Package.swift",
            ".git",
          }, { upward = true })[1])
          local client = vim.lsp.start({
            name = "sourcekit-lsp",
            cmd = { "sourcekit-lsp" },
            root_dir = root_dir,
          })
          vim.lsp.buf_attach_client(0, client)
        end,
        group = swift_lsp,
      })
    end,
  },
}
