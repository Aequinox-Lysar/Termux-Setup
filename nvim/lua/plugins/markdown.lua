return {
	-- Markdown Sytax & Tools
	{
		"plasticboy/vim-markdown",
		dependencies = { "godlygeek/tabular" },
		ft = { "markdown" },
		init = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_conceal = 0
			vim.g.vim_markdown_frontmatter = 1
		end,
	},

	-- Besseres Schreiben
	{
		"preservim/vim-pencil",
		ft = { "markdown" },
		config = function()
			vim.cmd([[autocmd FileType markdown call pencil#init({'wrap': 'soft'})]])
		end,
	},

	-- Tabellen und Ausrichtung
	
	{
		"junegunn/vim-easy-align",
		ft = { "markdown" },
		keys = {
			{ "ga", "<Plug>(EasyAlign)", mode = { "n", "x" } },
		},
		
	},
}
