-- ╭─────────────────────────────────────────────────────────╮
-- │                Custom Modules/Functions                 │
-- ╰─────────────────────────────────────────────────────────╯

local M = {}

local modes = {
    {
        mode = "Relative Number",
        signcolumn = "auto",
        bbq = true,
        gitsigns = true,
        rnum = true,
        num = false,
    },
    {
        mode = "Absolute Number",
        signcolumn = "auto",
        bbq = true,
        gitsigns = true,
        rnum = false,
        num = true,
    },
    {
        mode = "Zen Mode",
        signcolumn = "yes:2",
        bbq = false,
        gitsigns = false,
        rnum = false,
        num = false,
    },
}
local current_index = 1

function M.toggle_mode()
    local mode = modes[current_index]
    local current_buf = vim.api.nvim_get_current_buf()

    -- Set options based on the selected mode
    vim.opt.relativenumber = mode.rnum
    vim.opt.number = mode.num
    vim.opt.signcolumn = mode.signcolumn

    -- Toggle barbecue and gitsigns based on mode
    require("barbecue.ui").toggle(mode.bbq)
    if mode.gitsigns then
        require("gitsigns").attach(current_buf)
    else
        require("gitsigns").detach(current_buf)
    end

    -- Cycle through the modes
    current_index = (current_index % #modes) + 1
end

--- Toggle inlay hints
function M.toggle_inlay_hint()
    local is_enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(not is_enabled)
end

-- Toggle flow state mode,Disable most of the unnecessary plugins :oOc
_G.flow_state = _G.flow_state or 0
function M.toggle_flow()
    if _G.flow_state == 0 then
        vim.o.relativenumber = false
        vim.o.number = false
        vim.opt.signcolumn = "yes:4"
        require("barbecue.ui").toggle(false) -- Disable barbecue winbar
        _G.flow_state = 1
    else
        vim.o.relativenumber = true
        vim.o.number = true
        vim.opt.signcolumn = "auto"
        require("barbecue.ui").toggle(true) -- Enable barbecue winbar
        _G.flow_state = 0
    end
end

-- Autocommands
local autocmd = vim.api.nvim_create_autocmd
-- vim.b.miniindentscope_disable = true
-- autocmd("FileType", {
--     pattern = "help",
--     desc = "Disable 'mini.indentscope' help page",
--     callback = function(data)
--         vim.b[data.buf].miniindentscope_disable = true
--     end,
-- })

autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer,params: lsp.ProgressParams}}
    callback = function(ev)
        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
            id = "lsp_progress",
            title = "LSP Progress",
            opts = function(notif)
                notif.icon = ev.data.params.value.kind == "end" and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

autocmd("TextYankPost", {
    desc = "Highlight with yanking (copying) text",
    callback = function()
        vim.highlight.on_yank()
    end,
})

return M
