-- File: lua/chatgptnvim/popup.lua

local config = require('chatgptnvim.config')

local M = {}

-- Function to create a floating popup window
function M.create_popup(original, changed)
    local buf = vim.api.nvim_create_buf(false, true)

    local lines = {}
    table.insert(lines, "Original:")
    vim.list_extend(lines, vim.split(original, "\n"))
    table.insert(lines, "")
    table.insert(lines, "Changed:")
    vim.list_extend(lines, vim.split(changed, "\n"))

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    local width = math.ceil(vim.o.columns * (config.settings.screenPercentage / 100))
    local height = math.ceil(vim.o.lines * (config.settings.screenPercentage / 100))
    local col = math.ceil((vim.o.columns - width) / 2)
    local row = math.ceil((vim.o.lines - height) / 2)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
    })

    -- Keymap for accepting changes (Ctrl + Y)
    vim.api.nvim_buf_set_keymap(buf, "n", "<C-y>", "", {
        noremap = true,
        silent = true,
        callback = function()
            -- Replace the original text with the changed text
            local changed_lines = vim.split(changed, "\n")
            -- Assuming the popup was created in a temporary buffer, replace in the original buffer
            -- You might need to adjust the buffer replacement logic based on your use case
            vim.api.nvim_command('normal! gv"xy') -- Yank the visually selected text
            vim.api.nvim_buf_set_lines(0, 0, -1, false, changed_lines)
            vim.api.nvim_win_close(win, true)
        end,
    })

    vim.api.nvim_buf_set_option(buf, "modifiable", false)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
end

return M

