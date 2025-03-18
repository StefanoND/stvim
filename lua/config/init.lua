vim.g.do_filetype_lua = 1 -- Enable
-- vim.api.nvim_set_var("do_filetype_lua", 1)

-- recommended settings from nvim-tree documetation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Create group which will be cleared on reload so we don't have multiple autocommands
local StfGroup = augroup("Stf", { clear = true })

function R(name)
  require("plenary.reload").reload_module(name)
end

-- Highlight on yank
autocmd("TextYankPost", {
  group = StfGroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- Remove whitespace on save
autocmd({ "BufWritePre" }, {
  group = StfGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

require("config.set")
require("config.remap")

-- Load ftplugin files
local ftmodule = "ftplugin.%s"
local function loadftmodule(ft, action)
  local modname = ftmodule:format(ft)
  local _, res = pcall(require, modname)
  if type(res) == "table" then
    if type(res[action]) == "function" then
      res[action]()
    end
  elseif
    type(res) == "string"
    and not res:match("Module '" .. modname .. "' not found")
    and not res:match("	no file")
  then
    print(res)
  end
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "BufWinEnter", "Colorscheme" }, {
  pattern = { "*" },
  callback = function()
    loadftmodule(vim.bo.filetype, "ftplugin")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "*" },
  callback = function()
    loadftmodule(vim.bo.filetype, "newfile")
  end,
})

vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "VimEnter", "BufWinEnter", "Colorscheme" }, {
  pattern = { "*" },
  callback = function()
    loadftmodule(vim.bo.filetype, "syntax")
  end,
})
-- ftplugin end
