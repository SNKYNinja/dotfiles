return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
            "hrsh7th/nvim-cmp",
        },
        version = "*",
        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            completion = {
                accept = { auto_brackets = { enabled = true } },

                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 150,
                    treesitter_highlighting = true,
                    window = {
                        border = "rounded",
                        winblend = 0,
                        max_width = 50,
                        max_height = 15,
                    },
                },
                list = {
                    selection = function(ctx)
                        return ctx.mode == "cmdline" and "auto_insert" or "preselect"
                    end,
                },
                menu = {
                    border = "rounded",
                    winblend = 0,
                    cmdline_position = function()
                        if vim.g.ui_cmdline_pos ~= nil then
                            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
                            return { pos[1] - 1, pos[2] }
                        end
                        local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
                        return { vim.o.lines - height, 0 }
                    end,

                    draw = {
                        -- columns = {
                        --     { "kind_icon", "label", "label_description", gap = 1 },
                        --     { "kind" },
                        -- },
                        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
                        components = {
                            kind_icon = {
                                -- text = function(item)
                                --     local kind = require("lspkind").symbol_map[item.kind] or ""
                                --     return kind .. " "
                                -- end,
                                -- highlight = "BlinkCmpKindDefault",
                            },
                            label = { width = { max = 30 } },
                            label_description = { width = { max = 20 } },
                        },
                        treesitter = { "lsp" },
                    },
                },
            },

            -- My super-TAB configuration
            keymap = {
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<CR>"] = { "accept", "fallback" },

                ["<Tab>"] = {
                    function(cmp)
                        return cmp.select_next()
                    end,
                    "snippet_forward",
                    "fallback",
                },
                ["<S-Tab>"] = {
                    function(cmp)
                        return cmp.select_prev()
                    end,
                    "snippet_backward",
                    "fallback",
                },

                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-up>"] = { "scroll_documentation_up", "fallback" },
                ["<C-down>"] = { "scroll_documentation_down", "fallback" },
            },

            -- Experimental signature help support
            signature = {
                enabled = true,
                window = {
                    border = "rounded",
                    winblend = 0,
                    scrollbar = false,
                },
                trigger = {
                    show_on_insert_on_trigger_character = true,
                },
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                cmdline = function()
                    local type = vim.fn.getcmdtype()
                    -- Search forward and backward
                    if type == "/" or type == "?" then
                        return { "buffer" }
                    end
                    -- Commands
                    if type == ":" then
                        return { "cmdline" }
                    end
                    return {}
                end,
                providers = {
                    lsp = {
                        score_offset = 0, -- Boost/penalize the score of the items
                    },
                    path = {
                        min_keyword_length = 0,
                    },
                    snippets = {
                        min_keyword_length = 2,
                    },
                    buffer = {
                        min_keyword_length = 5,
                        max_items = 10,
                    },
                },
            },
        },
    },
}
