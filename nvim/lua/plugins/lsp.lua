return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- clangd mit neuer 0.12 API registrieren
      vim.lsp.config("clangd", {})
      vim.lsp.enable("clangd")
    end,
  },
}

