return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = true,
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
                end,
                desc = "NeoTree",
            },
            { "<leader>e", "<leader>fe", desc = "NeoTree", remap = true },
            {
                "<leader>ge",
                function()
                    require("neo-tree.command").execute({ source = "git_status", toggle = true })
                end,
                desc = "Git explorer",
            },
            {
                "<leader>be",
                function()
                    require("neo-tree.command").execute({ source = "buffers", toggle = true })
                end,
                desc = "Buffer explorer",
            },
        },
        config = function()
            local neotree = require("neo-tree")

            neotree.setup({
                close_if_last_window = true,
                popup_border_style = "rounded",
                enable_git_status = false,
                enable_diagnostics = true,
                sources = { "filesystem", "buffers", "document_symbols" },
                open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
                filesystem = {
                    bind_to_cwd = true,
                    follow_current_file = { enabled = true },
                    use_libuv_file_watcher = true,
                    hijack_netrw_behavior = "open_default",
                    filtered_items = {
                        visible = true,
                    },
                },
                window = {
                    position = "right",
                    width = 30,
                },
                default_component_configs = {
                    indent = {
                        indent_size = 2,
                        padding = 1,

                        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                    icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "󰜌",
                        provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
                            if node.type == "file" or node.type == "terminal" then
                                local success, web_devicons = pcall(require, "nvim-web-devicons")
                                local name = node.type == "terminal" and "terminal" or node.name
                                if success then
                                    local devicon, hl = web_devicons.get_icon(name)
                                    icon.text = devicon or icon.text
                                    icon.highlight = hl or icon.highlight
                                end
                            end
                        end,
                        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                        -- then these will never be used.
                        default = "*",
                        highlight = "NeoTreeFileIcon",
                    },
                    modified = {
                        symbol = "[+]",
                        highlight = "NeoTreeModified",
                    },
                    name = {
                        trailing_slash = false,
                        highlight = "NeoTreeFileName",
                    },
                    -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
                    file_size = {
                        enabled = true,
                        width = 12, -- width of the column
                        required_width = 64, -- min width of window required to show this column
                    },
                    type = {
                        enabled = true,
                        width = 10, -- width of the column
                        required_width = 122, -- min width of window required to show this column
                    },
                    last_modified = {
                        enabled = true,
                        width = 20, -- width of the column
                        required_width = 88, -- min width of window required to show this column
                    },
                    created = {
                        enabled = true,
                        width = 20, -- width of the column
                        required_width = 110, -- min width of window required to show this column
                    },
                    symlink_target = {
                        enabled = false,
                    },
                },
            })
        end,
    },
}
