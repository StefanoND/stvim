local M = {}

local vars = require("config.vars")

M.getOS = function()
  return vim.uv.os_uname().sysname
end

M.getOSLowerCase = function()
  return vim.uv.os_uname().sysname:lower()
end

M.ignoreAll = function()
  local lines = {}
  local ignorefile = vim.fn.getcwd() .. "/.allignore"
  if vim.fn.filereadable(ignorefile) == 1 then
    for line in io.lines(ignorefile) do
      table.insert(lines, line)
    end
    return lines
  end
  return nil
end

M.ignoreExplorer = function()
  local lines = {}
  local ignorefile = vim.fn.getcwd() .. "/.explorerignore"
  if vim.fn.filereadable(ignorefile) == 1 then
    for line in io.lines(ignorefile) do
      table.insert(lines, line)
    end
    return lines
  end
  return nil
end

M.ignoreFiles = function()
  local lines = {}
  local ignorefile = vim.fn.getcwd() .. "/.filesignore"
  if vim.fn.filereadable(ignorefile) == 1 then
    for line in io.lines(ignorefile) do
      table.insert(lines, line)
    end
    return lines
  end
  return nil
end

M.ignoreGrep = function()
  local lines = {}
  local ignorefile = vim.fn.getcwd() .. "/.grepignore"
  if vim.fn.filereadable(ignorefile) == 1 then
    for line in io.lines(ignorefile) do
      table.insert(lines, line)
    end
    return lines
  end
  return nil
end

M.ext = function(opts, args)
  vim.tbl_deep_extend("force", opts, args)
end

M.kmExt = function(args)
  vim.tbl_deep_extend("force", vars.kmOpts, args)
end

return M
