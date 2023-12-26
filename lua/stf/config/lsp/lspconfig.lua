local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
        vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
        vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)

        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)

        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

        vim.keymap.set({ "n", "x" }, "<leader>f", function()
            vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
        end, opts)
    end,
})

lspconfig.bashls.setup({
    on_attach = function(client, bufnr)
        print('hello bash')
    end,
    capabilities = lsp_defaults,
})

lspconfig.clangd.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client, bufnr)
        print('hello clang')
    end,
    capabilities = lsp_defaults,
})

lspconfig.cmake.setup({
    on_attach = function(client, bufnr)
        print('hello cmake')
    end,
    capabilities = lsp_defaults,
})

lspconfig.csharp_ls.setup({
    on_attach = function(client, bufnr)
        print('hello csharp')
    end,
    capabilities = lsp_defaults,
})

lspconfig.gdscript.setup({
    on_attach = function(client, bufnr)
        print('hello godot')
    end,
    capabilities = lsp_defaults,
})

lspconfig.jsonls.setup({
    on_attach = function(client, bufnr)
        print('hello json')
    end,
    capabilities = lsp_defaults,
})

lspconfig.lua_ls.setup({
    on_attach = function(client, bufnr)
        print('hello lua')
    end,
    capabilities = lsp_defaults,
})

lspconfig.omnisharp.setup({
    on_attach = function(client, bufnr)
        print('hello omnisharp')
    end,
    capabilities = lsp_defaults,
})

lspconfig.rust_analyzer.setup({
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        print('hello rust')
    end,
    capabilities = lsp_defaults,
})

lspconfig.sqlls.setup({
    on_attach = function(client, bufnr)
        print('hello sql')
    end,
    capabilities = lsp_defaults,
})

lspconfig.yamlls.setup({
    on_attach = function(client, bufnr)
        print('hello yaml')
    end,
    capabilities = lsp_defaults,
})

vim.diagnostic.config({
    virtual_text = true
})
