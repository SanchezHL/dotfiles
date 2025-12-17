-- NOTE: SIMILAR A utils.lua ESTE ARCHIVO NO SE USA.
-- Load our custom utility functions.
-- 'my_utils' corresponds to the filename 'lua/my_utils.lua'.
local utils = require("sanchezhl.utils")
-- Now, let's create keymaps that use our new function!

-- Map <leader>tv to open a VERTICAL terminal
vim.keymap.set("n", "<leader>tv", function()
	utils.open_terminal_here("vertical")
end, { desc = "Open Vertical Terminal (custom func)" })

-- Map <leader>th to open a HORIZONTAL terminal
vim.keymap.set("n", "<leader>ts", function()
	utils.open_terminal_here("horizontal")
end, { desc = "Open Horizontal Terminal (custom func)" })

-- Map <leader>th to open a HORIZONTAL terminal
vim.keymap.set("n", "<leader>tt", function()
	utils.print_test()
end, { desc = "TEST FUNCTION" })

-- You can also call it directly from the command line for testing:
-- :lua require('my_utils').open_terminal_here('vertical')
