-- NOTE: ESTE ARCHIVO NO SE UTILIZA. SOLO ES UNA PRUEBA PARA ABRIR LA TERMINAL EN LA RUTA DEL ARCHIVO DE LA VENTANA
-- Create a table to hold our functions. Let's call it M for "Module".
local M = {}

-- Define the function. It will open a terminal in the current file's directory.
-- We'll make it accept an argument for the direction ('vertical' or 'horizontal').
function M.open_terminal_here(direction)
	-- Default to vertical if no direction is given
	local split_cmd = "vsplit"
	if direction == "horizontal" then
		split_cmd = "split"
	end

	-- Build the full command to execute
	-- vim.fn.expand('%:p:h') is the Lua way to get the file's directory path
	local command = split_cmd .. " term://cd " .. vim.fn.expand("%:p:h") .. "& dir"

	-- Execute the command
	vim.cmd(command)
end

function M.print_test()
	print(vim.fn.expand("%:p:h"))
	local buf_id = vim.api.nvim_create_buf(true, false)
	vim.api.nvim_open_win(buf_id, false, { relative = "win", row = 3, col = 3, width = 12, height = 3 })
	vim.api.nvim_open_term(buf_id, {})
end
-- Return the module table so other files can use its functions
return M
