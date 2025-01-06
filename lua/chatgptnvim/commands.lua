-- File: lua/chatgptnvim/commands.lua

local config = require('chatgptnvim.config')
local api = require('chatgptnvim.api')
local popup = require('chatgptnvim.popup')

local M = {}

-- Helper function to get selected text
local function get_selected_text()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_row, start_col = start_pos[2], start_pos[3]
    local end_row, end_col = end_pos[2], end_pos[3]

    -- Adjust for zero-based indexing
    local lines = vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, end_row - 1, end_col, {})
    return table.concat(lines, "\n")
end

-- Function to handle different operations
local function handle_operation(operation)
    local original_text = get_selected_text()

    local prompt = config.settings.defaultPrompt

    if operation == "custom" then
        vim.ui.input({ prompt = "Enter custom instructions for ChatGPT: " }, function(input)
            if not input or input == "" then
                vim.notify("No instructions provided. Using default prompt.", vim.log.levels.WARN)
            else
                prompt = input
            end
            local full_prompt = "Original code:\n" .. original_text .. "\n\nInstructions:\n" .. prompt .. "\n\nModified code:"
            api.call_chatgpt_api(full_prompt, function(response)
                popup.create_popup(original_text, response)
            end)
        end)
    elseif operation == "completion" then
        local full_prompt = "Original code:\n" .. original_text .. "\n\nProvide code completion:"
        api.call_chatgpt_api(full_prompt, function(response)
            popup.create_popup(original_text, response)
        end)
    elseif operation == "refactor" then
        local full_prompt = "Original code:\n" .. original_text .. "\n\nRefactor the above code for better performance and readability:"
        api.call_chatgpt_api(full_prompt, function(response)
            popup.create_popup(original_text, response)
        end)
    end
end

-- Setup function to define commands and key mappings
function M.setup()
    -- Define user commands
    vim.api.nvim_create_user_command("ChatGptCodeCompletion", function()
        handle_operation("completion")
    end, { range = true })

    vim.api.nvim_create_user_command("ChatGptCustomInstruction", function()
        handle_operation("custom")
    end, { range = true })

    vim.api.nvim_create_user_command("ChatGptRefactor", function()
        handle_operation("refactor")
    end, { range = true })

    -- Define key mappings
    vim.api.nvim_set_keymap('v', '<leader>cc', ':ChatGptCodeCompletion<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<leader>ci', ':ChatGptCustomInstruction<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<leader>cr', ':ChatGptRefactor<CR>', { noremap = true, silent = true })
end

return M

