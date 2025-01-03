return {
    {
        "vuki656/package-info.nvim",
        ft = "json",
        dependencies = { "MunifTanjim/nui.nvim" },
        config = function()
            require("package-info").setup({
                autostart = true,
                package_manager = "npm",
                colors = {
                    up_to_date = "#3C4048", -- Text color for up to date dependency virtual text
                    outdated = "#d19a66", -- Text color for outdated dependency virtual text
                    invalid = "#ee4b2b", -- Text color for invalid dependency virtual text
                },
                hide_up_to_date = true,
            })

            -- Show dependency versions
            vim.keymap.set({ "n" }, "<leader>ns", require("package-info").show, { silent = true, noremap = true })

            -- Hide dependency versions
            vim.keymap.set({ "n" }, "<leader>nc", require("package-info").hide, { silent = true, noremap = true })

            -- Toggle dependency versions
            vim.keymap.set({ "n" }, "<leader>nt", require("package-info").toggle, { silent = true, noremap = true })

            -- Update dependency on the line
            vim.keymap.set({ "n" }, "<leader>nu", require("package-info").update, { silent = true, noremap = true })

            -- Delete dependency on the line
            vim.keymap.set({ "n" }, "<leader>nd", require("package-info").delete, { silent = true, noremap = true })

            -- Install a new dependency
            vim.keymap.set({ "n" }, "<leader>ni", require("package-info").install, { silent = true, noremap = true })

            -- Install a different dependency version
            vim.keymap.set(
                { "n" },
                "<leader>np",
                require("package-info").change_version,
                { silent = true, noremap = true }
            )
        end,
    },
}
