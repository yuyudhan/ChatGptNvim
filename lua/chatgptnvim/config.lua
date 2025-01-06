-- File: lua/chatgptnvim/config.lua

local M = {}

M.settings = {
    api_key = "", -- Users must provide their OpenAI API key
    screenPercentage = 80, -- Percentage of screen for popup
    model = "gpt-4o-mini", -- Default model
    defaultPrompt = "Please improve the following code according to the provided instructions:",
}

-- Setup function to merge user configurations with defaults
function M.setup(user_config)
    if user_config then
        M.settings = vim.tbl_deep_extend("force", M.settings, user_config)
    end
end

return M

