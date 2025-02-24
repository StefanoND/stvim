return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local terminal = require("toggleterm")

    terminal.setup({
      persist_size = true,
    })

    local opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<C-t>", "<cmd>lua require'toggleterm'.exec('yazi')<CR>", opts)

    vim.keymap.set("n", "<leader>ht", "<cmd>ToggleTerm<CR>", opts)
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
    vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])
  end,
}
