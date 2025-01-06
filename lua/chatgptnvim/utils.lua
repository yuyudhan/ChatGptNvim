-- File: lua/chatgptnvim/utils.lua

-- This file is optional as of now and not used, might be needed later on.

local M = {}

-- Logger function for consistent logging
function M.log(level, msg)
    vim.notify(msg, level)
end

return M

