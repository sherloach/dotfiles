return {
    -- {
    --     'JoosepAlviste/nvim-ts-context-commentstring',
    --     config = function()
    --         vim.g.skip_ts_context_commentstring_module = true
    --
    --         require('ts_context_commentstring').setup {
    --             enable_autocmd = false,
    --             languages = {
    --                 typescript = {
    --                     __default = '// %s',
    --                     tsx_element = '{/* %s */}',
    --                     tsx_fragment = '{/* %s */}',
    --                     tsx_attribute = '// %s',
    --                     comment = '// %s',
    --                 },
    --                 javascript = {
    --                     __default = '// %s',
    --                     jsx_element = '{/* %s */}',
    --                     jsx_fragment = '{/* %s */}',
    --                     jsx_attribute = '// %s',
    --                     comment = '// %s',
    --                 },
    --             },
    --         }
    --     end
    -- },

     'numToStr/Comment.nvim',
     config = function()
         require('Comment').setup {
             --
             -- pre_hook = function()
             --     return vim.bo.commentstring
             -- end,
         }
     end,
}
