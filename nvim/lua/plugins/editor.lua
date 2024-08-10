return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>E", false },
      { "<leader>e", ":Neotree toggle left<CR>", silent = true, desc = "Explorer Neotree" },
    },
    opts = function(_, opts)
      opts.window.mappings = {
        ["o"] = { "open", nowait = true },
        ["oc"] = "none",
        ["od"] = "none",
        ["og"] = "none",
        ["om"] = "none",
        ["on"] = "none",
        ["os"] = "none",
        ["ot"] = "none",
      }
      opts.filesystem.group_empty_dirs = true -- when true, empty folders will be grouped together
      opts.sort_case_insensitive = true
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      icons = {
        -- breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        -- separator = "▎",
        -- separator = " ",
        -- group = "+", -- symbol prepended to a group
        -- group = "↳ ", -- symbol prepended to a group
      },
      win = {
        border = "single",
      },
    },
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    event = "BufRead",
    config = function()
      require("hop").setup()
      local directions = require("hop.hint").HintDirection
      local hop = require("hop")

      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true, desc = "Hop Char 2" })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true, desc = "Hop Word" })
      vim.keymap.set("", "f", function()
        hop.hint_words({ direction = directions.AFTER_CURSOR })
      end, { remap = true, desc = "Hop Forward" })
      vim.keymap.set("", "F", function()
        hop.hint_words({ direction = directions.BEFORE_CURSOR })
      end, { remap = true, desc = "Hop Backward" })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- disable the keymap to grep files
      { "<leader>ff", false },
      { "<leader>fg", false },
      { "<leader>fb", false },
      -- change a keymap
      { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
      -- add a keymap to browse plugin files
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
  },
}
