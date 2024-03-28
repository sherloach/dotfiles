return {
	-- Autotag
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-treesitter.configs").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	},

	-- comments
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	-- useful when there are embedded languages in certain types of files (e.g. Vue or React)
	{ "joosepalviste/nvim-ts-context-commentstring", lazy = true },

	-- Zen mode
	{
		"folke/zen-mode.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			window = {
				backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
				-- height and width can be:
				-- * an absolute number of cells when > 1
				-- * a percentage of the width / height of the editor when <= 1
				-- * a function that returns the width or the height
				width = 0.65, -- width will be 80% of the editor width
				height = 1, -- height of the Zen window
				-- by default, no options are changed for the Zen window
				-- uncomment any of the options below, or add other vim.wo options you want to apply
				options = {
					-- signcolumn = "no", -- disable signcolumn
					-- number = false, -- disable number column
					-- relativenumber = false, -- disable relative numbers
					-- cursorline = false, -- disable cursorline
					-- cursorcolumn = false, -- disable cursor column
					-- foldcolumn = "0", -- disable fold column
					-- list = false, -- disable whitespace characters
				},
			},
			plugins = {
				-- neotree = { enable = true },
			},
		},
	},

	-- undo
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},

	-- Show progress
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({
				notification = { window = { winblend = 0 } },
			})
		end,
	},

	-- surround
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- lazy.nvim:
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"smoka7/hydra.nvim",
		},
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<Leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
	},
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
	},
	{
		"SmiteshP/nvim-navic",
		enabled = true,
		event = "BufReadPost",
		config = function()
			require("nvim-navic").setup({
				-- icons = require("lspkind").symbol_map,
				separator = "",
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client.server_capabilities.documentSymbolProvider then
						require("nvim-navic").attach(client, bufnr)
					end
					-- if not vim.tbl_contains({ "copilot", "null-ls", "ltex" }, client.name) then
					-- 	require("nvim-navic").attach(client, bufnr)
					-- end
				end,
			})
		end,
	},

	-- {
	--   "f-person/auto-dark-mode.nvim",
	--   config = {
	--     update_interval = 1000,
	--     set_dark_mode = function()
	--       vim.api.nvim_set_option("background", "dark")
	--       -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
	--       -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	--       -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
	--       -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	--       -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "#938AA9" })
	--       -- vim.api.nvim_set_hl(0, "LineNr", { bg = "#938AA9" })
	--       -- require('lualine').setup({
	--       --   options = {
	--       --     theme = 'solarized_dark',
	--       --   },
	--       -- })
	--     end,
	--     set_light_mode = function()
	--       vim.api.nvim_set_option("background", "dark")
	--       -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
	--       -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	--       -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "#938AA9" })
	--       -- vim.api.nvim_set_hl(0, "LineNr", { bg = "#938AA9" })
	--       -- require('lualine').setup({
	--       --   options = {
	--       --     theme = 'solarized_dark',
	--       --   },
	--       -- })
	--     end,
	--   },
	-- }
}
