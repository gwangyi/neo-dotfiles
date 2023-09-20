local path = vim.api.nvim_eval([[fnamemodify(resolve(expand('<sfile>:p')), ':h')]])
package.path = package.path .. ';' .. path .. '/lua/?.lua'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup('plugins')

local xdg_data_home = os.getenv("XDG_DATA_HOME")
if xdg_data_home == nil then
  xdg_data_home = "$HOME/.local/share"
end

vim.g.python3_host_prog = xdg_data_home .. "/venv/tools/bin/python3"

-- pcall(function() require 'corp/config' end)

-- vim: set sw=2 ts=2 et:
