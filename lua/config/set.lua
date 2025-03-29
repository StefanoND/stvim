local vars = require("config.vars")

-- Line numbers
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.relativenumber = true

vim.opt.encoding = "utf-8"

-- It's free real estate
-- vim.opt.cmdheight = 0
-- vim.cmd([[
--   autocmd VimEnter * silent !tmux set status off
--   autocmd VimLeave * silent !tmux set status on
-- ]])
vim.cmd([[autocmd VimLeave * silent !tmux set status on]])

vim.g.editorconfig = true

-- Enable function highlighting (affects both C and C++ files)
vim.g.cpp_function_highlight = 1

-- Enable highlighting of C++11 attributes
vim.g.cpp_attributes_highlight = 1

-- Highlight struct/class member variables (affects both C and C++ files)
vim.g.cpp_member_highlight = 1

-- Put all standard C and C++ keywords under Vim's highlight group 'Statement' (affects both C/C++ files)
vim.g.cpp_simple_highlight = 1

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

if vars.getOSLowerCase():match("windows") then
  vim.opt.undodir = os.getenv("UserProfile") .. "/.vim/undodir" -- Must create this folder
else -- I don't own/use a Mac, will update when/if I do
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Must create this folder
end

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
vim.cmd.colorscheme("catppuccin")

vim.opt.background = "dark" -- Colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes" -- Show sign column so that text doesn't shift

vim.opt.backspace = "indent,eol,start" -- Allow backspace on indent, end of line or insert mode start position

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

-- Split
vim.opt.splitright = true -- Split vertical window to the right
vim.opt.splitbelow = true -- Split horizontal window to the bottom

vim.opt.mousemoveevent = true
vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 60

-- Better completion experience
vim.opt.completeopt = "menu,menuone,preview,noselect"

-- Show gutter after column 105
vim.opt.textwidth = 105
vim.opt.colorcolumn = "+1"

-- Spelling
-- medical spellfile from https://github.com/melvio/medical-spell-files
vim.opt.spelllang = { "en_us", "pt_pt", "pt_br", "medical" }
vim.opt.spellfile = os.getenv("HOME") .. "/.config/nvim/spell/en.utf-8.add" -- extra words
vim.opt.spelloptions = "camel" -- Split camelCase words when spellchecking

-- Concealer for Neorg
vim.o.conceallevel = 2

-- Leading "᛫"
vim.opt.list = true
vim.opt.listchars:append("lead:᛫")

-- Folds
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "/",
  eob = " ",
}

vim.cmd("let g:netrw_liststlye = 3")

local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
  vim.fn.serverstart(pipepath)
end

vim.g.python3_host_prog = "/usr/bin/python3"
