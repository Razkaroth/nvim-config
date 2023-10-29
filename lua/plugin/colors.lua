return {
	{
		'srcery-colors/srcery-vim',
		name = 'srcery',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme srcery]])
			vim.api.nvim_set_hl(0, 'Normal', { blend = 20 })
			vim.api.nvim_set_hl(0, 'NormalFloat', { blend = 20 })
		end,
		opts = {
			srcery_bg_passthrough = 1
		}

	}
}
