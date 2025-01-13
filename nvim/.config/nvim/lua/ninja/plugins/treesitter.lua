return {
    {
        "nvim-treesitter/nvim-treesitter",
        name = "treesitter",
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vimdoc",
                    "lua",
                    "toml",
                    "json",
                    "html",
                    "css",
                    "javascript",
                    "typescript",
                    "markdown",
                    "python",
                    "cpp",
                    "java",
                    "dockerfile",
                },
                ignore_install = {},
                sync_install = false,
                auto_install = false,
                modules = {},
                highlight = {
                    enable = true,
                    use_languagetree = true,
                },
                indent = { enable = true },
            })
        end,
    },
}
