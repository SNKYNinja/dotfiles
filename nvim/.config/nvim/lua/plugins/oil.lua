return {
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                    natural_order = true,
                    is_always_hidden = function(name, _)
                        return name == ".." or name == ".git"
                    end,
                },
                float = {
                    padding = 2,
                    max_width = 90,
                    max_height = 0,
                },
                win_options = {
                    wrap = true,
                    winblend = 0,
                },
                keymaps = {
                    ["<C-c>"] = false,
                    ["q"] = "actions.close",
                },
            })
        end,
    },
    {
        "chrishrb/gx.nvim",
        keys = { { "gx", "<cmd>Browse<CR>", mode = { "n", "x" } } },
        cmd = { "Browse" },
        init = function()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
        submodules = false,
    },
}
