return {
    {
        "saghen/blink.cmp",
        version = "v0.*",
        event = { "LspAttach" },
        dependencies = {
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
        },
        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "enter" },
            sources = { -- sources for completion
                cmdline = { enabled = false },
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            completion = { -- completion options
                accept = {
                    auto_brackets = { enabled = true },
                },
                menu = {
                    border = vim.g.border_style,
                    scrolloff = 1,
                    scrollbar = false,
                    draw = {
                        -- columns = { { "label", "label_description", gap = 2 }, { "kind_icon", "kind", gap = 1 } },
                        columns = {
                            { "kind_icon" },
                            { "label", "kind", gap = 5 },
                        },
                        components = {
                            kind_icon = { -- sets lspkind for kind_icon
                                text = function(item)
                                    local kind = require("lspkind").symbol_map[item.kind] or ""
                                    return kind .. " "
                                end,
                            },
                        },
                        treesitter = { "lsp" },
                    },
                },
                documentation = {
                    treesitter_highlighting = true,
                    auto_show = true,
                    window = {
                        border = vim.g.border_style,
                        winblend = 0,
                        max_width = 50,
                        max_height = 15,
                    },
                },
                ghost_text = {
                    enabled = true,
                },
            },
            signature = { -- documentation for a function or method's signature
                enabled = true,
                window = {
                    border = vim.g.border_style,
                    winblend = 0,
                    scrollbar = false,
                },
                trigger = {
                    show_on_insert_on_trigger_character = true,
                },
            },
        },
    },
}
