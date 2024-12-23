return {
    {  -- Vim Fugitive (Git)
        "tpope/vim-fugitive",
        config = function ()
            -- Open Git status with <leader>gs, but only if inside a Git repository
            vim.keymap.set("n", "<leader>gs", function()
                local handle = io.popen("git rev-parse --is-inside-work-tree 2>/dev/null")
                local result = handle:read("*a")
                handle:close()

                if result:find("true") then
                    vim.cmd.Git()
                else
                    -- Display a friendly error message with an icon
                    vim.notify("Not inside a Git repository", vim.log.levels.ERROR, {
                        icon = "",  -- Git icon from Nerd Fonts
                        title = "Git Error"
                    })
                end
            end, { desc = "[G]it [S]tatus (only if inside a Git repository)" })
        end
    }
}
