return {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		opts = {
			defaults = {
				file_ignore_patterns = { ".git/", "node_modules/" }
			}
		},
		dependencies = {
			'nvim-lua/plenary.nvim',
			"nvim-tree/nvim-web-devicons",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
		},
		config = function()
			local telescope = require('telescope')
			local builtin = require('telescope.builtin')
			local keymap = vim.keymap

			pcall(telescope.load_extension, 'fzf')

			keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]ind [R]ecently opened files'})
			keymap.set('n', '<leader>fo', builtin.buffers, { desc = '[F]ind currently [O]pened files'})
			keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind  [F]ile in directory'})
			keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]find current [W]ord' })
			keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
			keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[F]ind [R]resume' })

			keymap.set('n', '<leader>gf', builtin.buffers, { desc = 'Find [G]it repo [F]iles'})

			keymap.set('n', '<leader>fs', function()
				local searchTerm = vim.fn.input('Grep >> ')
				builtin.grep_string({ search = searchTerm })
			end, { desc = '[F]ind [String] by grep'})

			keymap.set('n', '<leader>/', function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end, { desc = '[/] Fuzzily search in current buffer' })
		end	      
	},
}
