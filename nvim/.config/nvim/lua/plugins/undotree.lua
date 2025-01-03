return {
    {
        "mbbill/undotree",

        -- Setting up keymap
        config = function()
            -- Toggle UndoTree with <leader>u
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndoTree" })
        end,
    },
}
