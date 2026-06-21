local SntmUI = {}

function SntmUI.new(new_buf)
    -- Create the window
    local new_win = vim.api.nvim_open_win(new_buf, true,
    {
	title= 'Terminal List',
	relative='win',
	row=10,
	col=30,
	width=100,
	height=10,
    })
    if new_win == 0 then
	error("cannot create window")
    end
end

function SntmUI.open(buff)
end

return SntmUI
