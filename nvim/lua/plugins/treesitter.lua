return {
  {
    "nvim-treesitter/nvim-treesitter",
	branch = 'main',
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = { "c", "bash", "lua", "python", "markdown", "markdown_inline", },
	sync_install = false,
	auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  }
}
