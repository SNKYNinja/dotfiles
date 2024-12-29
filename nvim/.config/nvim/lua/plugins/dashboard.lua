return {
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local logo = [[
███╗   ██╗██╗███╗   ██╗     ██╗ █████╗
 ████╗  ██║██║████╗  ██║     ██║██╔══██╗
 ██╔██╗ ██║██║██╔██╗ ██║     ██║███████║
 ██║╚██╗██║██║██║╚██╗██║██   ██║██╔══██║
 ██║ ╚████║██║██║ ╚████║╚█████╔╝██║  ██║
 ╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚════╝ ╚═╝  ╚═╝
            ]]

            logo = string.rep("\n", 8) .. logo .. "\n\n"

            local dashboard = require("dashboard")

            dashboard.setup({
                hide = {
                    winbar = false,
                },
                config = {
                    header = vim.split(logo, "\n"),
                    footer = { "", "󰘳 Find your new horizon.." },
                },
            })

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "DashboardLoaded",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end
        end,
    },
}
