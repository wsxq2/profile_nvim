-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" }, -- 匹配 C 和 C++ 文件类型
  callback = function()
    vim.bo.modeline = false -- 禁用 modeline
    vim.opt_local.shiftwidth = 4 -- 设置缩进宽度为 4
    vim.opt_local.tabstop = 4 -- 设置 Tab 显示宽度为 4
  end,
})
