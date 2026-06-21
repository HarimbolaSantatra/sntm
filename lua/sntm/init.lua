local M = {}

---@class Config
---@field term_num int Maximum number of terminal
local config = {
  term_num = 1, -- number of terminal
  -- TODO: implement other method
  -- "split" (default) or "vsplit" for splits, "tab" to open on a new tab, "normal" to open on current window
  win_mode = "split" 
}

M.config = config

-- Variable that store the list of all Term object
local buf_states = {
}

-- Variable that store the buffer ID of the next terminal; this should be incremented
local current_buf_id = 0

-- definition of a table of type vim.api.keyset.win_config
local win_config = {
    split = "right",
    win = 0
}

---Create a terminal buffer
---@return int Buffer ID of the created buffer
function create_term()
    local last_buf = vim.api.nvim_get_current_buf()
    local term_buf = vim.api.nvim_create_buf(true, false) 
    if term_buf == 0 then
	error("Cannot create a new buffer for the terminal")
    else
	current_buf_id = current_buf_id + 1
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
    end

    vim.api.nvim_win_set_buf(0, last_buf)

    return term_buf

end

---Open the terminal in the current window
---@param term_buf int The ID of the terminal buffer
function open_term(term_buf)
    if M.config.win_mode == 'vsplit' then
	vim.api.nvim_open_win(term_buf, true, { split = 'right', win = 0, }) 
    elseif M.config.win_mode == 'split' then
	vim.api.nvim_open_win(term_buf, true, { split = 'below', win = 0, }) 
    elseif M.config.win_mode == 'normal' then
	vim.api.nvim_win_set_buf(0, term_buf)
    end
    vim.cmd("startinsert")
end

function main()
    if current_buf_id == 0 then
	local buf_id = create_term()
	open_term(buf_id)
    else
	open_term(current_buf_id)
    end
end

-- VIM COMMANDS
-- vim.api.nvim_create_user_command('Sntm', create_term, {})
vim.api.nvim_create_user_command('Sntm', main, {})
vim.keymap.set('n', '<leader>r', main)

return M
