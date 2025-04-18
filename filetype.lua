vim.filetype.add({
  filename = {
    ["vifmrc"] = "vim",
  },
  extension = {
    -- nss = "nwscript",
    -- local = "sh",
    razor = "razor",
    cshtml = "razor",
    rasi = "rasi",
    rofi = "rasi",
    wofi = "rasi",
  },
  pattern = {
    -- [".*%.nss$"] = "nwscript",
    ["*.fish"] = "fish",
    ["*.razor"] = "razor",
    ["*.cshtml"] = "razor",
    [".bash.*.local"] = "sh",
    [".blerc"] = "sh",
    [".*/waybar/config"] = "jsonc",
    [".*/mako/config"] = "dosini",
    [".*/kitty/.+%.conf"] = "kitty",
    [".*/hypr/.+%.conf"] = "hyprlang",
    ["%.env%.[%w_.-]+"] = "sh",
  },
})
