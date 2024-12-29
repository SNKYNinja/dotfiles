return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            "saghen/blink.cmp",
        },
        config = function()
            -- import lspconfig plugin
            local lspconfig = require("lspconfig")

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })

            local on_attach = function(_, bufnr)
                -- Keybindings for LSP
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = "LSP: " .. desc
                    end

                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
                end

                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
                vim.keymap.set("n", "d]", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = 0 })
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")

                nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
                nmap("gD", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", "Open Definiton in Vertical Split")
                nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
                nmap("<leader>Ic", vim.lsp.buf.incoming_calls, "[I]ncoming [C]alls")
                nmap("<leader>Oc", vim.lsp.buf.outgoing_calls, "[O]utgoing [C]alls")
                nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
                nmap("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
                nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
            end

            -- used to enable autocompletion (assign to every lsp server config)
            local capabilities = require('blink.cmp').get_lsp_capabilities()

            -- Change the Diagnostic symbols in the sign column (gutter)
            -- (not in youtube nvim video)
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- Setup LSP servers
            lspconfig["html"].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            lspconfig["ts_ls"].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            lspconfig["cssls"].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            lspconfig["tailwindcss"].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            lspconfig["emmet_ls"].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" }
            }

            lspconfig["pyright"].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            lspconfig["lua_ls"].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            lspconfig["clangd"].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end,
    },
}
