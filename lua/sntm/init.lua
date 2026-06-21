local M = {}

---@class Config
---@field term_num int Maximum number of terminal
local config = {
  term_num = 1, -- number of terminal
  -- TODO: implement "tab"
  win_mode = "split" -- "split" for split or "tab" to open on a new tab
}

M.config = config

-- Variable that store the list of all Term object
local buf_states = {
}

-- Variable that store the buffer ID of the next terminal; this should be incremented
local current_buf_id = 1

-- definition of a table of type vim.api.keyset.win_config
local win_config = {
    split = "right",
    win = 0
}

-- UI creation
ui = require("sntm.ui")

-- Create a terminal buffer
function create_term()

    local term_buf = vim.api.nvim_create_buf(true, false) 
    if term_buf == 0 then
	error("Cannot create a new buffer for the terminal")
    else
	buf_states[current_buf_id] = term_buf
    end

    vim.api.nvim_win_set_buf(0, term_buf)

    local job = vim.fn.jobstart(
	'bash', 
	{
	    term = true,
	    stderr_buffered = true,
	    stdout_buffered = true,
	    on_exit = function () end,
	    on_stdout = function () end,
	    on_stderr = function () end,
	}
    )

    if job == 0 then
	error("Invalid arguments")
    elseif job == -1 then
	error("Unhandled error! See 'jobstart'")
    else
	vim.cmd("startinsert")
    end

end

-- VIM COMMANDS
vim.api.nvim_create_user_command('SntmHealth', 'lua require("sntm.health").health_check()', {})
-- vim.api.nvim_create_user_command('Sntm', create_term, {})
vim.api.nvim_create_user_command('Test', create_term, {})


return M
