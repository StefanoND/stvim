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
