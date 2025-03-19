local M = {}

-- Credits to @wookayin: https://github.com/tpope/vim-repeat/issues/92#issuecomment-1826910664
-- I modified his code to accept both string and function instead of function only
-- Not to be used directly, use my the function below it: rMap

---Register a global internal keymap that wraps `rhs` to be repeatable.
---@param mode string|table keymap mode, see vim.keymap.set()
---@param lhs string lhs of the internal keymap to be created, should be in the form `<Plug>(...)`
---@param rhs string|function rhs of the keymap, see vim.keymap.set()
---@return string The name of a registered internal `<Plug>(name)` keymap. Make sure you use { remap = true }.
M.make_repeatable_keymap = function(mode, lhs, rhs)
  vim.validate({
    mode = { mode, { "string", "table" } },
    rhs = { rhs, { "string", "function" }, lhs = { name = "string" } },
  })
  if not vim.startswith(lhs, "<Plug>") then
    error("`lhs` should start with `<Plug>`, given: " .. lhs)
  end
  vim.keymap.set(mode, lhs, function()
    (type(rhs) == "function" and rhs or vim.api.nvim_input)(rhs)
    vim.fn["repeat#set"](vim.api.nvim_replace_termcodes(lhs, true, true, true))
  end)
  return lhs
end

---Wrapper of the above function, you use it just like you would use vim.keymap.set
---The only difference is the added "name" argument, which will be used by the function above
---@param mode string: Text mode: (i)nsert, (v)isual, (n)ormal, etc
---@param key  string: Keymap: a, b, <C-s>, <leader>a, etc
---@param name string: UNIQUE name for the function, can be whatever you want as long as it's UNIQUE
---@param func string|function: Function to run
---@param opts table: vim.keymap.set's options: description, remap, silent, etc
M.repeatable_keymap_set = function(mode, key, name, func, opts)
  mode = mode or ""
  key = key or ""
  name = name or ""
  opts = opts or {}
  func = func or ""
  assert(type(mode) == "string", "Expected a string value from mode")
  assert(mode and #mode > 0, "Expected a non-empty string from mode")
  assert(type(key) == "string", "Expected a string value from key")
  assert(key and #key > 0, "Expected a non-empty string from key")
  assert(type(name) == "string", "Expected a string value from name")
  assert(name and #name > 0, "Expected a non-empty string from name")
  assert(type(opts) == "table", "Expected a table from opts")
  assert(type(func) == "function" or "string", "Expected a function or string from func")
  assert(func and #func > 0, "Expected a non-empty string from func")
  vim.keymap.set(mode, key, M.make_repeatable_keymap(mode, "<Plug>(" .. name .. ")", func), opts)
end

-- M.format = function(bufnr, async, timeout)
--   timeout = timeout or nil
--   async = async or false
--   vim.lsp.buf.format({
--     async = async,
--     timeout_ms = timeout,
--     bufnr = bufnr,
--     filter = function(client)
--       return client.name == "null-ls"
--     end,
--   })
-- end

return M
