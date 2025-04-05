return { -- C#
  "OmniSharp/omnisharp-vim",
  ft = { "cs", "csharp" },
  dependencies = {
    { "ctrlpvim/ctrlp.vim", ft = { "cs", "csharp" } },
    { "Hoffs/omnisharp-extended-lsp.nvim", ft = { "cs", "csharp" } },
  },
}
