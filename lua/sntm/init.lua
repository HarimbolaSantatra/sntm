local M = {}

---@class Config
---@field term_num int Maximum number of terminal
local config = {
  term_num = 1,
}
M.config = config

---@class Term
local term = {
}

-- Variable that store the list of all Term object
local states = {
}

-- Variable that store the id of the next Term object
-- this should be incremented
local id = 1

-- Function that create a new terminal
function create_term(name)
    local term_name
    if name == nil then
	term_name = "term"..id
    else
	term_name = name
    end
    states[id] = {
	id = id,
	name = term_name
    }
    id = id + 1
    vim.cmd(":term")
end

-- Function that list all existing terminal

-- Function that attach to an existing terminal

-- Function that delete an existing terminal

-- Function that rename an existing terminal

-- VIM COMMANDS
vim.api.nvim_create_user_command('SntmHealth', 'lua require("sntm.health").health_check()', {})
vim.api.nvim_create_user_command('Sntm', 'lua create_term()', {})


return M
