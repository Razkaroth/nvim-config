return {  
	{
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    config = function() 
	    require'nvim-treesitter.configs'.setup {
		    -- A list of parser names, or "all" (the five listed parsers should always be installed)
		    ensure_installed = { "rust", "lua", "vim", "vimdoc", "query", 'typescript', 'javascript', 'python' },
		    -- Install parsers synchronously (only applied to `ensure_installed`)
		    sync_install = false,
		    -- Automatically install missing parsers when entering buffer
		    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		    auto_install = true,
		    highlight = {
			    enable = true,
			    additional_vim_regex_highlighting = false,
		    },
		    indent = { enable = true },
		    incremental_selection = {
			    enable = true,
			    keymaps = {
				    init_selection = '<C-space>',
				    node_incremental = '<C-space>',
				    scope_incremental = '<C-s>',
				    node_decremental = '<m-space>',
			    }
		    },
		    textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
	    }
    end
  },
}
