-- File: lua/chatgptnvim/init.lua

local config = require('chatgptnvim.config')
local api = require('chatgptnvim.api')
local popup = require('chatgptnvim.popup')
local commands = require('chatgptnvim.commands')

local M = {}

-- Setup function to initialize the plugin with user configurations
function M.setup(user_config)
    config.setup(user_config)
    commands.setup()
end

-- Expose API functions if needed externally
M.api = api
M.popup = popup

return M

