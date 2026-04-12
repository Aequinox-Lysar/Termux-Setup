vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/LuaSnip"})

-- Markdown darf auch TEX-Snippets sehen
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		require("luasnip").filetype_extend("markdown", {"tex"})
	end,
})

vim.wo.relativenumber = true
vim.o.cmdheight = 2
vim.opt.termguicolors = true
vim.notify = require("notify")
vim.wo.number = true
vim.cmd("set guicursor=a:ver100")
-- Keybinding TAB for Snippet expansion
local ls = require("luasnip")

vim.keymap.set({"i","s"}, "<Tab>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  else
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<Tab>", true, false, true),
      "n",
      true
    )
  end
end, {silent = true})

vim.keymap.set({"i","s"}, "<S-Tab>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  else
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true),
      "n",
      true
    )
  end
end, {silent = true})
-- vim.cmd[[colorscheme industry]]
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
vim.keymap.set({ "n", "v", "o" }, "ö", ")" )
vim.keymap.set({ "n", "v", "o" }, "ä", "(" )
vim.api.nvim_set_keymap("n", "<leader>g", ":w<CR>:terminal glow %<CR>", { noremap = true, silent = true } )
vim.api.nvim_create_autocmd("FileType", { 
	pattern = "c",
	callback = function()
		vim.bo.shiftwidth = 2
		vim.bo.tabstop = 2
		vim.bo.expandtab = true
	end,
})

-- Neues Protokoll aus Template erstellen
vim.api.nvim_create_user_command('Protokoll', function()
	-- Dateiname abfragen
	local name = vim.fn.input("Name des neuen Protokolls: ")

	-- Datum automatisch hinzufügen (YYYY-MM-DD)
	local date = os.date("%Y.%m.%d")
	local filename = date .. "_" .. name .. ".md"

	-- Protokolle- Ordner definieren
	local folder = "protokolle/"
	local filepath = folder .. filename

	-- Neue Datei im Ordner öffnen
	vim.cmd("edit " .. filepath)

	-- Template einfügen
	local template_path = "protokolle/protokoll_template.md"
	vim.cmd("read " .. template_path)

	-- Cursor an den Anfang der Datei setzen
	vim.cmd("normal gg")
	print("Neues Protokoll erstellt: " .. filename)
end, {})

