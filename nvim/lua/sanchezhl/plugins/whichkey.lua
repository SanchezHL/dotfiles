return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").add({
			{ "<leader>c", group = "[C]ode", hidden = false },
			{ "<leader>d", group = "[D]ocument", hidden = false },
			{ "<leader>h", group = "Git [H]unk", hidden = false },
			{ "<leader>r", group = "[R]ename", hidden = false },
			{ "<leader>s", group = "[S]earch", hidden = false },
			{ "<leader>t", group = "[T]oggle", hidden = false },
			{ "<leader>w", group = "[W]orkspace", hidden = false },
		})
		-- visual mode
		require("which-key").add({
			{ "<leader>h", desc = "Git [H]unk", mode = "v" },
		})
	end,
}
