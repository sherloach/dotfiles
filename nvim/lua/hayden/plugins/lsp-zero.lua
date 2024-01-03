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
        local lsp_zero = require('lsp-zero')

        lsp_zero.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
            vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
            vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set("n", "gl", function()
                local float = vim.diagnostic.config().float

                if float then
                    local config = type(float) == "table" and float or {}
                    config.scope = "line"

                    vim.diagnostic.open_float(config)
                end
            end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        end)

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { 'tsserver', 'rust_analyzer' },
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }
        })

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_window = require('cmp.config.window')

        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip', keyword_length = 2 },
                { name = 'buffer',  keyword_length = 3 },
            },
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            window = {
                completion = cmp_window.bordered(),
                documentation = cmp_window.bordered(),
            },
        })
    end,
}
