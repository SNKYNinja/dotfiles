return {
    {
        "neovim/nvim-lspconfig",
        name = "lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        event = { "BufReadPost", "BufNewFile" },
        keys = function()
            require("mappings").lsp()
        end,
        dependencies = { "saghen/blink.cmp" },
        config = function()
            local lspconfig = require("lspconfig")

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
            capabilities = vim.tbl_deep_extend("force", capabilities, {
                workspace = {
                    didChangeWatchedFiles = {
                        relativePatternSupport = true,
                    },
                },
            })

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = vim.g.border_style,
            })

            local on_attach = function(_, bufnr)
                -- TOOD: Register keybinds
            end

            local severs = {
                lua_ls = {},
                html = {},
                cssls = {},
                ts_ls = {},
                tailwindcss = {},
                emmet_ls = {
                    filetypes = {
                        "html",
                        "typescriptreact",
                        "javascriptreact",
                        "css",
                        "sass",
                        "scss",
                        "less",
                        "svelte",
                    },
                },
                pyright = {},
                clangd = {},
                jdtls = {},
            }

            for server, config in pairs(severs) do
                lspconfig[server].setup(vim.tbl_deep_extend("force", {
                    on_attach = on_attach,
                    capabilities = capabilities,
                }, config))
            end
        end,
    },
}
