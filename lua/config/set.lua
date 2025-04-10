-- Opt-in to use filetype.lua for setting custom filetypes
vim.g.do_filetype_lua = 1 -- Enable

-- recommended settings
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- vim.g.netrw_keepdir = 1

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Line numbers
vim.o.nu = true
vim.o.rnu = true

-- This is not needed with yanky
-- OSC 52 (Operating System Command) support
-- Control sequence that causes the terminal emulator to write to or read from the system clipboard.
-- vim.g.clipboard = {
--   name = "OSC 52",
--   copy = {
--     ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
--   },
--   paste = {
--     ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
--   },
-- }

-- Clipboard accross everything
-- vim.opt.clipboard:append("unnamedplus") -- Use system clipboard as default register
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

-- Set python3 host prog
vim.g.python3_host_prog = "/usr/bin/python3"

-- Disable Perl, Ruby
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- 1 to use the stdio version of OmniSharp-roslyn (Recommended), 0 for HTTP version (Not recommended)
vim.g.OmniSharp_server_stdio = 1

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
vim.opt.undolevels = 10000

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

vim.opt.hidden = true -- Keep buffers in memory
vim.opt.termguicolors = true -- Use truecolor in the terminal
vim.opt.background = "dark" -- Colorschemes that can be light or dark will be made dark
vim.opt.backspace = "indent,eol,start" -- Allow backspace on indent, end of line or insert mode start position
vim.opt.splitright = true -- Split vertical window to the right
vim.opt.splitbelow = true -- Split horizontal window to the bottom
vim.opt.showmode = false -- Dont show mode since we have a statusline
vim.opt.mouse = "a" -- Enable mouse mode
-- vim.opt.mousemoveevent = true
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.scrolloff = 8 -- Lines of context
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
vim.opt.completeopt = "menu,menuone,preview,noselect" -- Better completion experience
vim.opt.textwidth = 105 -- Max width/columns
vim.opt.colorcolumn = "+1" -- Show gutter after textwidth
vim.opt.signcolumn = "yes" -- Show sign column so that text doesn't shift

-- Spelling
-- medical spellfile from https://github.com/melvio/medical-spell-files
-- vim.opt.spelllang = { "en_us", "pt_pt", "pt_br", "medical" }
-- vim.opt.spelllang = { "en_us", "pt_pt", "medical" }
vim.opt.spelllang = { "en_us" }
vim.opt.spellfile = { os.getenv("HOME") .. "/.config/nvim/spell/en.utf-8.add" } -- extra words
vim.opt.spelloptions = "camel" -- Split camelCase words when spellchecking

vim.g.commentstring = "" -- Mini.nvim comment

vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings
vim.opt.list = true -- Show some invisible characters (tab...
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

-- Highlight groups
vim.api.nvim_set_hl(0, "hl_black", { fg = "#cdd6f4", bg = "#11111b" })
vim.api.nvim_set_hl(0, "hl_magenta", { fg = "#11111b", bg = "#f5c2e7" })
vim.api.nvim_set_hl(0, "hl_cyan", { fg = "#11111b", bg = "#94e2d5" })
vim.api.nvim_set_hl(0, "hl_white", { fg = "#11111b", bg = "#cdd6f4" })
vim.api.nvim_set_hl(0, "hl_rosewate", { fg = "#11111b", bg = "#f5e0dc" })
vim.api.nvim_set_hl(0, "hl_flamingo", { fg = "#11111b", bg = "#f2cdcd" })
vim.api.nvim_set_hl(0, "hl_pink", { fg = "#11111b", bg = "#f5c2e7" })
vim.api.nvim_set_hl(0, "hl_mauve", { fg = "#11111b", bg = "#cba6f7" })
vim.api.nvim_set_hl(0, "hl_red", { fg = "#11111b", bg = "#f38ba8" })
vim.api.nvim_set_hl(0, "hl_maroon", { fg = "#11111b", bg = "#eba0ac" })
vim.api.nvim_set_hl(0, "hl_peach", { fg = "#11111b", bg = "#fab387" })
vim.api.nvim_set_hl(0, "hl_yellow", { fg = "#11111b", bg = "#f9e2af" })
vim.api.nvim_set_hl(0, "hl_green", { fg = "#11111b", bg = "#a6e3a1" })
vim.api.nvim_set_hl(0, "hl_teal", { fg = "#11111b", bg = "#94e2d5" })
vim.api.nvim_set_hl(0, "hl_sky", { fg = "#11111b", bg = "#89dceb" })
vim.api.nvim_set_hl(0, "hl_sapphire", { fg = "#11111b", bg = "#74c7ec" })
vim.api.nvim_set_hl(0, "hl_blue", { fg = "#11111b", bg = "#89b4fa" })
vim.api.nvim_set_hl(0, "hl_lavender", { fg = "#11111b", bg = "#b4befe" })
vim.api.nvim_set_hl(0, "hl_text", { fg = "#11111b", bg = "#cdd6f4" })
vim.api.nvim_set_hl(0, "hl_subtext1", { fg = "#11111b", bg = "#bac2de" })
vim.api.nvim_set_hl(0, "hl_subtext0", { fg = "#11111b", bg = "#a6adc8" })
vim.api.nvim_set_hl(0, "hl_overlay2", { fg = "#11111b", bg = "#9399b2" })
vim.api.nvim_set_hl(0, "hl_overlay1", { fg = "#11111b", bg = "#7f849c" })
vim.api.nvim_set_hl(0, "hl_overlay0", { fg = "#cdd6f4", bg = "#6c7086" })
vim.api.nvim_set_hl(0, "hl_surface2", { fg = "#cdd6f4", bg = "#585b70" })
vim.api.nvim_set_hl(0, "hl_surface1", { fg = "#cdd6f4", bg = "#45475a" })
vim.api.nvim_set_hl(0, "hl_surface0", { fg = "#cdd6f4", bg = "#313244" })
vim.api.nvim_set_hl(0, "hl_base", { fg = "#cdd6f4", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_mantle", { fg = "#cdd6f4", bg = "#181825" })
vim.api.nvim_set_hl(0, "hl_crust", { fg = "#cdd6f4", bg = "#11111b" })

vim.api.nvim_set_hl(0, "hl_fg_black", { fg = "#11111b", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_magenta", { fg = "#f5c2e7", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_cyan", { fg = "#94e2d5", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_white", { fg = "#cdd6f4", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_rosewate", { fg = "#f5e0dc", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_flamingo", { fg = "#f2cdcd", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_pink", { fg = "#f5c2e7", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_mauve", { fg = "#cba6f7", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_red", { fg = "#f38ba8", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_maroon", { fg = "#eba0ac", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_peach", { fg = "#fab387", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_yellow", { fg = "#f9e2af", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_green", { fg = "#a6e3a1", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_teal", { fg = "#94e2d5", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_sky", { fg = "#89dceb", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_sapphire", { fg = "#74c7ec", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_blue", { fg = "#89b4fa", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_lavender", { fg = "#b4befe", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_text", { fg = "#cdd6f4", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_subtext1", { fg = "#bac2de", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_subtext0", { fg = "#a6adc8", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_overlay2", { fg = "#9399b2", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_overlay1", { fg = "#7f849c", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_overlay0", { fg = "#6c7086", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_surface2", { fg = "#585b70", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_surface1", { fg = "#45475a", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_surface0", { fg = "#313244", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_base", { fg = "#1e1e2e", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_mantle", { fg = "#181825", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "hl_fg_crust", { fg = "#11111b", bg = "#1e1e2e" })

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.g.conceallevel = 0
vim.o.conceallevel = 0
-- Set conceallevel for certain file types
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("ft_conceal"),
  pattern = { "*.md", "*.json", "*.org", "*.norg", "markdown", "markdown.mdx", "rmd", "org", "norg" },
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- -- Fix conceallevel for json files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   group = augroup("json_conceal"),
--   pattern = { "json", "jsonc", "json5" },
--   callback = function()
--     vim.opt_local.conceallevel = 0
--   end,
-- })

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Godot
local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
if not (vim.uv or vim.loop).fs_stat(pipepath) then
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
