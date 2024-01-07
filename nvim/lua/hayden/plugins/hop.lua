return {
  "phaazon/hop.nvim",
  event = "BufRead",
  config = function()
    require("hop").setup()
    local directions = require('hop.hint').HintDirection
    local hop = require('hop')

    vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
    vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    vim.keymap.set('', 'f', function()
      hop.hint_words({ direction = directions.AFTER_CURSOR })
    end, { remap = true })
    vim.keymap.set('', 'F', function()
      hop.hint_words({ direction = directions.BEFORE_CURSOR })
    end, { remap = true })
  end
}
