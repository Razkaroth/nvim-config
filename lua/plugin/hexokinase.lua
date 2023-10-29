return {
	{
		"RRethy/vim-hexokinase",
		run = "make hexokinase",
		config = function()
			vim.g.Hexokinase_highlighters = { 'virtual' }
		end,
		build = function()
			vim.fn.system { 'make', 'hexokinase' }
		end,	
	}
}
