local opts = { noremap = true, silent = true }

return {
  vim.keymap.set({ "n", "x" }, "s", "<Nop>", opts),
}
