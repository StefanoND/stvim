-- Opt-in to use filetype.lua for setting custom filetypes
vim.g.do_filetype_lua = 1 -- Enable

-- recommended settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Line numbers
vim.o.nu = true
vim.o.rnu = true

-- Clipboard accross everything
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard as default register
-- OSC 52 (Operating System Command) support
-- Control sequence that causes the terminal emulator to write to or read from the system clipboard.
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

-- Set python3 host prog
vim.g.python3_host_prog = "/usr/bin/python3"

-- Disable Perl, Ruby
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Turn on/off tmux statusline on vim enter/leave
vim.cmd([[silent !tmux set status off]])
vim.cmd([[autocmd VimLeave * silent !tmux set status on]])

-- It's free real estate
-- vim.opt.cmdheight = 0
-- vim.cmd([[
--   autocmd VimEnter * silent !tmux set status off
--   autocmd VimLeave * silent !tmux set status on
-- ]])

vim.g.editorconfig = true

-- Tab and indentation
vim.opt.tabstop = 2 -- 2 Spaces for tabs
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2 -- 2 Spaces for indent width
vim.opt.expandtab = true -- Expand tab to spaces
vim.opt.cindent = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Copy indent from current line when starting a new one
vim.opt.wrap = false

vim.opt.breakindent = true
vim.opt.linebreak = true

-- Undo
vim.opt.swapfile = false
vim.opt.backup = false

local funcs = require("config.functions")

-- if funcs.getOSLowerCase():match("windows") then
--   if vim.fn.filereadable(os.getenv("UserProfile") .. "/.vim/undodir") == 0 then
--   end
--   vim.opt.undodir = os.getenv("UserProfile") .. "/.vim/undodir" -- Must create this folder
-- else -- I don't own/use a Mac, will update when/if I do
--   if vim.fn.filereadable(os.getenv("HOME") .. "/.vim/undodir") == 0 then
--     vim.cmd(":!mkdir -p" .. os.getenv("HOME") .. "/.vim/undodir")
--   end
--   vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Must create this folder
-- end

-- if vim.fn.filereadable(os.getenv("HOME") .. "/.vim/undodir") == 0 then
--   vim.cmd(":!mkdir -p" .. os.getenv("HOME") .. "/.vim/undodir")
-- end
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.undofile = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- If mixed case in search, assumes case-sensitive

vim.opt.cursorline = true -- Highlight current/cursor line

-- Keep buffers in memory
vim.opt.hidden = true

-- Use truecolor in the terminal
vim.opt.termguicolors = true

vim.opt.background = "dark" -- Colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes" -- Show sign column so that text doesn't shift

vim.opt.backspace = "indent,eol,start" -- Allow backspace on indent, end of line or insert mode start position

-- Split
vim.opt.splitright = true -- Split vertical window to the right
vim.opt.splitbelow = true -- Split horizontal window to the bottom

-- vim.opt.mousemoveevent = true
vim.opt.scrolloff = 8
-- vim.opt.isfname:append("@-@")

vim.opt.updatetime = 30

-- Better completion experience
vim.opt.completeopt = "menu,menuone,preview,noselect"

-- Show gutter after column 105
vim.opt.textwidth = 105
vim.opt.colorcolumn = "+1"

-- Spelling
-- medical spellfile from https://github.com/melvio/medical-spell-files
vim.opt.spelllang = { "en_us", "pt_pt", "pt_br", "medical" }
vim.opt.spellfile = { os.getenv("HOME") .. "/.config/nvim/spell/en.utf-8.add" } -- extra words
vim.opt.spelloptions = "camel" -- Split camelCase words when spellchecking

-- Mini.nvim comment
vim.g.commentstring = ""

-- Concealer for Neorg
vim.o.conceallevel = 2

-- Leading "᛫"
vim.opt.list = true
vim.opt.listchars:append("lead:᛫")

-- Folds
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = false
vim.o.foldmethod = "manual"
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "/",
  eob = " ",
}

-- Godot
local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
  vim.fn.serverstart(pipepath)
end

vim.cmd("let g:netrw_liststlye = 3")

-- Reenable DoMatchParen if it was disabled by a BigFile
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local vars = require("config.vars")
    local maxSize = vars.maxFileSize
    local size = vim.fn.getfsize(vim.fn.expand("%"))
    if size >= maxSize then
      -- vim.cmd([[autocmd BufDelete * silent :DoMatchParen]])
      vim.cmd([[:DoMatchParen]])
    end
  end,
})

-- ftplugin start
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
