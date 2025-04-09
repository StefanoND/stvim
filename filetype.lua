vim.filetype.add({
  filename = {
    ["vifmrc"] = "vim",
  },
  extension = {
    -- nss = "nwscript",
    -- local = "sh",
    rasi = "rasi",
    rofi = "rasi",
    wofi = "rasi",
  },
  pattern = {
    -- [".*%.nss$"] = "nwscript",
    ["*.fish"] = "fish",
    [".bash.*.local"] = "sh",
    [".blerc"] = "sh",
    [".*/waybar/config"] = "jsonc",
    [".*/mako/config"] = "dosini",
    [".*/kitty/.+%.conf"] = "kitty",
    [".*/hypr/.+%.conf"] = "hyprlang",
    ["%.env%.[%w_.-]+"] = "sh",
  },
})
