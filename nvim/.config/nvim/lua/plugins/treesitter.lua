return {
    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false, -- Load Treesitter immediately
        main = "nvim-treesitter.configs", -- Sets main module to use for opts
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true, -- Automatically install missing parsers
                sync_install = false, -- Install parsers asynchronously
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true,
                },
                auto_tag = {
                    enable = true,
                },
                indent = { enable = true }, -- Enable indentation
                ensure_installed = {
                    "html",
                    "javascript",
                    "typescript",
                    "c",
                    "c",
                    "cpp",
                    "css",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "markdown",
                    "markdown_inline",
                    "dockerfile",
                    "gitignore",
                    "json",
                },
                ignore_install = {},
                modules = {},
            })
        end,
    },
}
