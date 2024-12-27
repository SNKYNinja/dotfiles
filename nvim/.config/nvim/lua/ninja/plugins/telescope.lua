return {
    { -- Fuzzy Finder (files, lsp, etc)
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        event = "VimEnter",
        branch = "0.1.x",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { -- If encountering errors, see telescope-fzf-native README for installation instructions
                "nvim-telescope/telescope-fzf-native.nvim",

                -- build is used to run some command when the plugin is installed/updated.
                -- This is only run then, not every time Neovim starts up.
                build = "make",

                -- cond is a condition used to determine whether this plugin should be
                -- installed and loaded.
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
            -- Useful for getting pretty icons, but requires a Nerd Font.
            { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
            -- Trouble integration
            { "folke/trouble.nvim" },
        },
        config = function()
            -- Enable line numbers in Telescope previewer for better context.
            vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")

            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")
            local telescope = require("telescope")
            -- local trouble = require("trouble.sources.telescope")

            local devicons = require("nvim-web-devicons")

            local harpoon_add_mark = function(prompt_bufnr)
                local entry = require("telescope.actions.state").get_selected_entry()
                if entry and entry.path then
                    local list = require("harpoon"):list()
                    local harpoon_config = list.config
                    local item = harpoon_config.create_list_item(harpoon_config, entry[1])
                    list:add(item)

                    local filetype = vim.fn.fnamemodify(entry.path, ":e") -- Get file extension
                    local icon, _ = devicons.get_icon(entry.path, filetype, { default = true })

                    vim.notify(string.format("%s Added to Harpoon: %s", icon, entry.path), vim.log.levels.INFO, {
                        title = "Harpoon",
                        timeout = 2000,
                    })

                    actions.close(prompt_bufnr)                                                  -- Close Telescope
                else
                    local warn_icon, _ = devicons.get_icon("warning", "txt", { default = true }) -- Use "warning" icon or a default one
                    vim.notify(string.format("%s No file selected to add to Harpoon", warn_icon), vim.log.levels.WARN, {
                        title = "Harpoon",
                        timeout = 2000,
                    })
                end
            end

            local formattedName = function(_, path)
                local tail = vim.fs.basename(path)
                local parent = vim.fs.dirname(path)
                if parent == "." then
                    return tail
                end
                return string.format("%s\t\t%s", tail, parent)
            end

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "TelescopeResults",
                callback = function(ctx)
                    vim.api.nvim_buf_call(ctx.buf, function()
                        vim.fn.matchadd("TelescopeParent", "\t\t.*$")
                        vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
                    end
                    )
                end,
            })

            -- Telescope setup with icon customization
            telescope.setup {
                pickers = {
                    find_files = {
                        path_display = formattedName,
                    },
                    git_files = {
                        path_display = formattedName,
                    },
                    buffers = {
                        path_display = formattedName,
                        mappings = {
                            n = {
                                ["x"] = actions.delete_buffer,
                            },
                        },
                    },
                    oldfiles = {
                        path_display = formattedName,
                    },
                    colorscheme = {
                        enable_preview = true,
                    },
                },
                defaults = {
                    mappings = {
                        i = {
                            ["<C-r>"] = harpoon_add_mark,
                        },
                        n = {
                            ["<C-r>"] = harpoon_add_mark,
                        },
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    prompt_prefix = "   ",
                    selection_caret = " ",
                    entry_prefix = "  ",
                    initial_mode = "insert",
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    file_ignore_patterns = { "node_modules", ".class" },
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter, --caused(now Fixed) problems with Telescope current_buffer_fuzzy_find (have to find what it is used for)
                    path_display = { "truncate" },
                    winblend = 0,
                    border = {},
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    color_devicons = true,
                    use_less = true,
                    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    -- Developer configurations: Not meant for general override
                    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
                }
            }

            -- Optionally, you can add additional keybindings for your Telescope commands
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ps', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end
            )
        end
    },
}
