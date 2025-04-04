-- Opt-in to use filetype.lua for setting custom filetypes
vim.g.do_filetype_lua = 1 -- Enable

vim.filetype.add({
  -- extension = {
  --   nss = "nwscript",
  --   local = "sh",
  -- },
  pattern = {
    -- [".*%.nss$"] = "nwscript",
    ["*.fish"] = "fish",
    [".bash.*.local"] = "sh",
    [".blerc"] = "sh",
  },
})
