return {
  -- TokyoNight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    name = "tokyonight.nvim",
    opts = {
      style = "storm",	-- dunkle Variante
      transparent = true,  --transparenter Hintergrund
      terminal_colors = true,
      styles = {
	sidebars = "transparent",
	floats = "transparent"
      },
    },
    config = function(_, opts)
	-- Colorscheme aktivieren
	vim.cmd.colorscheme("tokyonight")
	vim.cmd([[highlight Normal guibg=NONE ctermbg=NONE]])
	vim.cmd([[highlight NormalNC guibg=NONE ctermbg=NONE]])
    end,
  },
}
