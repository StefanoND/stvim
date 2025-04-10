return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdx", "rmd", "org", "norg" },
    lazy = true,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
      require("render-markdown").setup({
        pipe_table = { preset = "round" },
        link = {
          render_modes = true,
        },
        completions = {
          lsp = { enabled = true },
        },
        preset = "obsidian",
        filetypes = { "markdown", "markdown.mdx" },
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "markdown.mdx", "rmd", "org", "norg" },
    lazy = true,
    build = "cd app && npm install && git restore .",
    -- build = "cd app && yarn install && git restore .", -- If you prefer yarn over npm
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      require("config.keymaps.languages.markdown")
    end,
  },
}
