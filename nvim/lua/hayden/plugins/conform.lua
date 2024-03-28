return {
	"stevearc/conform.nvim",
	opts = {},
	config = function(_, opts)
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})

		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "autopep8" },
				rust = { "rustfmt" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})

		local conform = require("conform")
		conform.formatters.jq = {
			args = { "--indent", "4" },
		}
		conform.formatters.stylua = {
			-- args = { '--indent', '4' },
			prepend_args = { "--config-path=" .. vim.env.HOME .. "/.config/stylua.toml" },
		}
	end,
}
