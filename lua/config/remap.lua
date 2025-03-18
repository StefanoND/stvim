local opts = { noremap = true, silent = true }

local extend = function(desc)
  vim.tbl_deep_extend("force", opts, { desc = desc })
end

local keymap = vim.keymap.set

-- Vertical selection
keymap({ "n", "v" }, "<leader>ven", ":set ve=none<CR>", opts)

-- Rectangular selection
keymap({ "n", "v" }, "<leader>vea", ":set ve=all<CR>", opts)
keymap("n", "<leader>su", vim.cmd.UndotreeToggle, extend("Open undotree"))
keymap("n", "<leader>nh", "<cmd>nohl<CR>", extend("[N]o [H]ighlights"))
keymap("n", "D", "<cmd>bd<CR>", extend("Cloes current buffer/tab"))
keymap("n", "<M-d>", "<cmd>delete<CR>", extend("Same as 'dd'"))

keymap("n", "J", "mzJ`z", extend("J stays at beginning of line"))
keymap("n", "<C-u>", "<C-u>zz", extend("Half-page jump up"))
keymap("n", "<C-d>", "<C-d>zz", extend("Half-page jump down"))

-- Keep stuff centered while moving around
keymap("n", "*", "*zzzv", extend("Next item in search"))
keymap("n", "#", "#zzzv", extend("Previous item in search"))
keymap("n", ",", ",zzzv", extend("Next item in search"))
keymap("n", ";", ";zzzv", extend("Previous item in search"))
keymap("n", "n", "nzzzv", extend("Next item in search"))
keymap("n", "N", "Nzzzv", extend("Previous item in search"))

-- Register stuff
keymap({ "n", "v" }, "<leader>d", [["_d]], extend("Delete without copying deleted content"))
keymap("x", "<leader>p", [["_dP]], extend("Paste preserving yank"))

keymap("n", "Q", "<Nop>", extend("No more [Q]uitting by mistake"))

-- Keep things highlighted after moving with < and >
keymap("v", "<", "<gv", extend("Move left keeping highlight"))
keymap("v", ">", ">gv", extend("Move right keeping highlight"))

-- tmux
keymap(
  "n",
  "<C-f>",
  "<cmd>silent !tmux neww ~/dotfiles/scripts/tmux-sessionizer<CR>",
  extend("Search and create a new tmux session based on the basename of the file chosen")
)
keymap("n", "<M-Left>", "<cmd>TmuxNavigateLeft<CR>", extend("Move to left window"))
keymap("n", "<M-Down>", "<cmd>TmuxNavigateDown<CR>", extend("Move to Down window"))
keymap("n", "<M-Up>", "<cmd>TmuxNavigateUp<CR>", extend("Move to Up window"))
keymap("n", "<M-Right>", "<cmd>TmuxNavigateRight<CR>", extend("Move to right window"))

keymap("n", "j", "gj", extend("Move down wrapped line"))
keymap("n", "k", "gk", extend("Move up wrapped line"))

keymap("n", "<leader>tts", function()
  vim.cmd([[silent !tmux set status]])
end, extend("Toggle tmux statusline on/off"))

-- Window management
keymap("n", "<C-M-i>", "<C-w>+", extend("Increase Split relative to the current active split"))
keymap("n", "<C-M-d>", "<C-w>-", extend("Decrease Split relative to the current active split"))
keymap("n", "<M-m>", "<C-w><", extend("Increase Split relative to the current active split"))
keymap("n", "<M-p>", "<C-w>>", extend("Decrease Split relative to the current active split"))
keymap("n", "<leader>sv", "<C-w>v<C-w>><C-w>><C-w>><C-w>>", extend("Split window vertically"))
keymap("n", "<leader>sh", "<C-w>s", extend("Split window horizontally"))
keymap("n", "<leader>se", "<C-w>=", extend("Make splits equal size"))
keymap("n", "<leader>sx", "<cmd>close<CR>", extend("Close current split"))

-- -- Tab management
-- keymap("n", "<leader>to", "<cmd>tabnew<CR>", extend("Open new tab"))
-- keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", extend("Open current buffer in new tab"))
-- keymap("n", "<leader>tt", "<cmd>tabn<CR>", extend("Go to previous tab"))
-- keymap("n", "<leader>tT", "<cmd>tabp<CR>", extend("Go to previous tab"))
-- keymap("n", "<leader>tx", "<cmd>tabclose<CR>", extend("Close current tab"))

-- vim's quickfix navigation
keymap("n", "<C-k>", "<cmd>cnext<CR>zz", extend("Next Quickfix"))
keymap("n", "<C-j>", "<cmd>cprev<CR>zz", extend("Previous Quickfix"))
keymap("n", "<leader>po", "<cmd>copen<CR>zz", extend("Open Quickfix"))
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", extend("Next Location"))
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", extend("Previous Location"))

keymap(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]],
  extend("Replace all instances of the word under the cursor")
)

keymap(
  "v",
  "<leader>s",
  [[y:<C-u>%s/<C-r>0/<C-r>0/gI<Left><Left><Left>]],
  extend("Replace all instances of the selection")
)

keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", extend("Same as 'chmod +x file'"))

keymap("n", "<leader>it", "<cmd>InspectTree<CR>", extend("Inspect Tree"))

keymap("n", "<leader><leader>", function()
  vim.cmd("so")
end, extend("Shout Out"))

-- Diff
keymap("n", "<leader>dt", ":windo diffthis<CR>", extend("Diff current split windows"))
keymap("n", "<leader>do", ":windo diffoff<CR>", extend("Stop Diff"))

-- splits a one liner {} block separated by ';' into separate lines
keymap("n", "]j", "f{i<CR><ESC>lli<CR><ESC>f;a<CR><ESC>f;a<CR><ESC>f;a<CR><ESC>f;a<CR><ESC>")
