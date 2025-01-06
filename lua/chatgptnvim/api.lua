-- File: lua/chatgptnvim/api.lua

local config = require('chatgptnvim.config')
local Job = require('plenary.job')

local M = {}

-- Logger function for consistent logging
local function log(level, msg)
    vim.notify(msg, level)
end

-- Function to call ChatGPT API
function M.call_chatgpt_api(prompt, callback)
    if config.settings.api_key == "" then
        log(vim.log.levels.ERROR, "OpenAI API key is not set. Please configure it using setup function.")
        return
    end

    local payload = vim.json.encode({
        model = config.settings.model,
        prompt = prompt,
        temperature = 0.7,
        max_tokens = 2048,
    })

    Job:new({
        command = "curl",
        args = {
            "-s",
            "-X",
            "POST",
            "https://api.openai.com/v1/completions",
            "-H", "Authorization: Bearer " .. config.settings.api_key,
            "-H", "Content-Type: application/json",
            "-d", payload,
        },
        on_exit = function(j, return_val)
            if return_val == 0 then
                local result = table.concat(j:result(), "\n")
                local parsed = vim.json.decode(result)
                if parsed and parsed.choices and parsed.choices[1] then
                    callback(parsed.choices[1].text)
                else
                    log(vim.log.levels.ERROR, "Unexpected API response")
                end
            else
                log(vim.log.levels.ERROR, "API call failed with return value: " .. return_val)
            end
        end,
    }):start()
end

return M

