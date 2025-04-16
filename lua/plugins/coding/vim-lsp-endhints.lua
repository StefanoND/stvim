return {
  "chrisgrieser/nvim-lsp-endhints",
  enabled = true,
  version = false,
  event = "LspAttach",
  opts = function()
    return {}
  end,
  config = function(_, opts)
    require("lsp-endhints").setup(opts)
  end,
}
