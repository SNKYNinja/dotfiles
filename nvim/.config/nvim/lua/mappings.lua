local modules = require("modules")
local wk = require("which-key")

local function map(mode, keys, action, desc, icon)
    desc = desc or ""
    local opts = { noremap = true, silent = true, desc = desc }
    vim.keymap.set(mode, keys, action, opts)

    if icon then
        wk.add({
            { keys, icon = icon },
        })
    end
end

local M = {}
M.map = map

M.general = function()
    -- Insert movement
    map("i", "<C-h>", "<Left>")
    map("i", "<C-j>", "<Down>")
    map("i", "<C-k>", "<Up>")
    map("i", "<C-l>", "<Right>")

    -- Copy and paste in the same cursor position
    map("n", "p", function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        vim.cmd("put")
        vim.api.nvim_win_set_cursor(0, { row + 1, col })
    end)

    -- Insert escape
    map("i", "jj", "<esc>")
    map("i", "<C-c>", "<esc>")

    -- Save only on new changes
    map("n", "<C-s>", "<cmd>update<CR>")

    -- Switching splits
    map("n", "<C-h>", "<C-w>h")
    map("n", "<C-j>", "<C-w>j")
    map("n", "<C-k>", "<C-w>k")
    map("n", "<C-l>", "<C-w>l")

    -- Buffer navigation
    map("n", "<Tab>", "<cmd>bnext<CR>")
    map("n", "<s-Tab>", "<cmd>bprev<CR>")

    -- Resize splits
    map("n", "<A-k>", ":resize +2<CR>")
    map("n", "<A-j>", ":resize -2<CR>")
    map("n", "<A-h>", ":vertical resize +2<CR>")
    map("n", "<A-l>", ":vertical resize -2<CR>")

    -- Center cursor on scroll
    map("n", "<C-d>", "<C-d>zz")
    map("n", "<C-u>", "<C-u>zz")

    -- Search and help mappings
    map("v", "??", 'y:h <C-R>"<cr>"') -- Show vim help
    map("v", "?/", 'y:/ <C-R>"<cr>"') -- Search across the buffer
end

M.misc = function()
    map("n", "<leader>tm", function()
        modules.toggle_mode()
    end, "[T]oggle [Mode]", "")

    -- map("n", "<leader>tf", function()
    --     modules.toggle_flow()
    -- end, "[T]oggle [F]low", "")
end

M.oil = function()
    map("n", "-", "<cmd>Oil<CR>", "Project View (Netrw)")
end

M.mini = function()
    local minipick = require("mini.pick")
    local miniextra = require("mini.extra")
    local minivisits = require("mini.visits")
    local builtin = minipick.builtin
    local pickers = miniextra.pickers
    local search = ""
    local git = ""

    map({ "n" }, "<leader>ff", function()
        builtin.files()
    end, "[F]ind [Files]", search)

    map({ "n" }, "<leader>fh", function()
        builtin.help()
    end, "[F]ind [H]elp", search)

    map({ "n" }, "<leader>fk", function()
        pickers.keymaps()
    end, "[F]ind [K]eymaps", search)

    map({ "n" }, "<leader>fg", function()
        builtin.grep_live()
    end, "[F]ind [G]rep", search)

    map({ "n" }, "<leader>fr", function()
        builtin.resume()
    end, "[F]ind [R]esume", search)

    map("n", "<leader>dp", function()
        pickers.diagnostic()
    end, "[D]iagnostics in [Picker]", search)

    map("n", "<leader>gh", function()
        pickers.git_hunks()
    end, "[F]ind Git [H]unks", git)

    map("n", "<leader>gc", function()
        pickers.git_commits()
    end, "[F]ind Git [C]ommits", git)

    map("n", "<A-s>", function()
        miniextra.pickers.visit_paths({ filter = "todo" })
    end, "Add file to todolist", "")

    map("n", "<A-a>", function()
        minivisits.add_label("todo")
    end, "Remove file from todolist", "")

    map("n", "<A-A>", function()
        minivisits.remove_label()
    end, "Remove label from file", "")
end

M.gitsigns = function()
    -- TODO: Add gitsigns mappings
end

M.lsp = function()
    -- TODO: Add lsp mappings
end

M.conform = function()
    map({ "n", "v" }, "<leader>mp", function()
        require("conform").format({
            lsp_format = "fallback",
            timeout_ms = 1000,
        })
    end, "[M]ake [P]retty", "󰉼")
end

M.neotree = function()
    local tree = ""

    -- `show` flag -> no focus
    map("n", "<leader>ee", "<cmd>Neotree toggle show<CR>", "Neotree Toggle", tree)
    map("n", "<leader>eg", "<cmd>Neotree git_status show<CR>", "Neotree Git Status", tree)
    map("n", "<leader>eb", "<cmd>Neotree buffers<CR> show", "Neotree Buffers", tree)
end

return M
