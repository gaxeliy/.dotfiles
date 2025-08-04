-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "basedpyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8

vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    severity_limit = "Warning",
    format = function(diagnostic)
      return diagnostic.message:gsub("\n.*", "") -- только первая строка
    end,
  },
  virtual_lines = false,
})

local ns = vim.api.nvim_create_namespace("ExpandedDiagnostics")

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local lnum = cursor[1] - 1

    -- Получаем диагностики только для текущей строки
    local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum })

    -- Показываем их с virtual_lines
    vim.diagnostic.show(ns, bufnr, diagnostics, {
      virtual_lines = true,
      virtual_text = false,
    })
  end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.diagnostic.hide(ns, bufnr)
  end,
})
