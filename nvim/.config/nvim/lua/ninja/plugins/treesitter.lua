return {
    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false, -- Load Treesitter immediately
        main = "nvim-treesitter.configs", -- Sets main module to use for opts

        config = function()
            require'nvim-treesitter.configs'.setup {
                auto_install = true, -- Automatically install missing parsers
                sync_install = false, -- Install parsers asynchronously
                highlight = { 
                    enable = true, 
                    additional_vim_regex_highlighting = false, 
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
                    "markdown_inline" 
                },
            }
        end
    },
}