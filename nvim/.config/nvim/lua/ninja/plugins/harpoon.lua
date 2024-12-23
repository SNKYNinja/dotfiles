return
{
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()
        -- REQUIRED

        -- Add current file to Harpoon list with <leader>a
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
            { desc = "[A]dd current file to Harpoon list" })

        -- Toggle Harpoon quick menu with <C-e>
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Toggle Harpoon quick menu" })

        -- Select specific file from Harpoon list with <C-h>, <C-t>, <C-n>, and <C-s>
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end,
            { desc = "Select first file in Harpoon list" })
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end,
            { desc = "Select second file in Harpoon list" })
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end,
            { desc = "Select third file in Harpoon list" })
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end,
            { desc = "Select fourth file in Harpoon list" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end,
            { desc = "Toggle to previous file in Harpoon list" })
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end,
            { desc = "Toggle to next file in Harpoon list" })

        harpoon:setup({})

        -- Basic telescope configuration for Harpoon files
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        -- Open Harpoon files using Telescope with <C-e>
        vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
            { desc = "Open Harpoon files in Telescope" })
    end,
}
