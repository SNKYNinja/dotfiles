-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        { import = "themes" },

        { "tpope/vim-sleuth" }, -- Vim Sleuth (Detect tabstop and shiftwidth automatically)

        { "windwp/nvim-ts-autotag" },

        { "wakatime/vim-wakatime", lazy = false },

        -- { "christoomey/vim-tmux-navigator" },

        { import = "plugins" },
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = false,
        notify = false, -- get a notification when changes are found
    },
}, {
    rocks = {
        enabled = false,
    },
    ui = {
        border = "solid",
        title = "lazy.nvim",
        size = { width = 0.9, height = 0.9 },
    },
})
