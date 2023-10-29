return {
	{
		'theprimeagen/harpoon',
		config = function()
			local keymap = vim.keymap
			keymap.set('n', '<leader>h1', function() require('harpoon.ui').nav_file(1) end,
			{ desc = 'Open [1]st file in Harpoon' })
			keymap.set('n', '<leader>h2', function() require('harpoon.ui').nav_file(2) end,
			{ desc = 'Open [2]nd file in Harpoon' })
			keymap.set('n', '<leader>h3', function() require('harpoon.ui').nav_file(3) end,
			{ desc = 'Open [3]rd file in Harpoon' })
			keymap.set('n', '<leader>h4', function() require('harpoon.ui').nav_file(4) end,
			{ desc = 'Open [4]th file in Harpoon' })
			keymap.set('n', '<leader>h5', function() require('harpoon.ui').nav_file(5) end,
			{ desc = 'Open [5]th file in Harpoon' })
			keymap.set('n', '<leader>hm', function() require('harpoon.mark').add_file() end,
			{ desc = 'Add [H]arpoon [M]ark file' })
			vim.keymap.set('n', '<leader>hu', function() require('harpoon.mark').remove_file() end,
			{ desc = '[H]arpoon file [U]nmark' })
			-- set leader leader h to toggle Harpoon
			vim.keymap.set('n', '<leader>ht', function() require('harpoon.ui').toggle_quick_menu() end,
			{ desc = '[H]arpoon [T]oggle' })
		end
	}
}
