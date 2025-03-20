-- Opt-in to use filetype.lua for setting custom filetypes
-- vim.g.do_filetype_lua = 1 -- Enable
vim.api.nvim_set_var("do_filetype_lua", 1)

vim.filetype.add({
  -- extension = {
  --   nss = "nwscript",
  --   local = "sh",
  -- },
  pattern = {
    -- [".*%.nss$"] = "nwscript",
    [".bash.*.local"] = "sh",
    [".blerc"] = "sh",
  },
})
