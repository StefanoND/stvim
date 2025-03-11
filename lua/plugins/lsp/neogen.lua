return {
  "danymat/neogen",
  dependencies = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
  config = function()
    local neogen = require("neogen")

    local opts = { noremap = true, silent = true }

    neogen.setup({
      snippet_engine = "luasnip",
    })

    vim.keymap.set("n", "<leader>ngf", function()
      neogen.generate({ type = "func" })
    end, opts)
    vim.keymap.set("n", "<leader>ngc", function()
      neogen.generate({ type = "class" })
    end, opts)
    vim.keymap.set("n", "<leader>ngt", function()
      neogen.generate({ type = "type" })
    end, opts)
  end,
}
