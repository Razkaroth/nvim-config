return {
	{
		"tpope/vim-fugitive",
		config = function ()
			vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Open [G]it [S]tatus' })
		end
	},
	{
		"tpope/vim-rhubarb"
	}
} 
