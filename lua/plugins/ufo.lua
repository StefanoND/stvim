return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
  event = "BufRead",
  keys = {
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      desc = "Open all folds",
    },
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      desc = "Close all folds",
    },
    {
      "zC",
      function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end,
      desc = "Peek at folded lines",
    },
  },
  config = function(_, opts)
    local ftmap = {
      vim = "indent",
      lua = { "lsp", "indent" },
    }

    return vim.tbl_extend("force", opts, {
      provider_selector = function(_, filetype, _)
        return ftmap[filetype] or { "treesitter", "indent" }
      end,
      close_fold_kinds_for_ft = { default = { "imports" } },
    })
  end,
}
