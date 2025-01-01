return {
    {
        "whoop-t/tokyonight.nvim",
        -- "folke/tokyonight.nvim",
        lazy = false, -- Load immediately (not lazily)
        priority = 110, -- Highest priority to load first
        config = function()
            require("tokyonight").setup({
                style = "storm",
                light_style = "day",
                transparent = false,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = { italic = true, bold = true },
                    -- Background styles: "dark", "transparent", or "normal"
                    sidebars = "normal",
                    floats = "normal",
                },
                day_brightness = 0.3, -- Adjusts brightness for the day style (0 to 1)
                dim_inactive = true, -- Dims inactive windows
                lualine_bold = true, -- Bold section headers in lualine theme
                cache = true,
                plugins = {
                    all = not package.loaded.lazy, -- Enable all plugins if not using lazy.nvim
                    auto = true, -- Automatically enable needed plugins for lazy.nvim
                },
                -- on_colors = function(colors) end,
                terminal_colors = true,
                -- on_highlights = function(highlights, colors) end,
            })

            -- Apply the colorscheme
            vim.cmd.colorscheme("tokyonight")
        end,
    },
}
