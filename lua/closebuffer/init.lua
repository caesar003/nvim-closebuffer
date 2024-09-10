-- Neovim CloseBuffer Plugin (Lua Version)
-- Author: Caesar003
-- Email: caesarmuksid@gmail.com
-- Repo: https://github.com/caesar003/vim-closebuffer
-- Last Modified: 2024-09-09
--
-- Description:
-- This plugin safely closes the current buffer without disrupting split windows
-- by switching to another buffer before closing the current one.
-- It also handles unsaved buffers by prompting the user to save, discard, or cancel.

local M = {}

-- Check if a buffer is modified
local function is_buffer_modified(buf)
  return vim.fn.getbufvar(buf, '&modified') == 1
end

-- Force close the specified buffer with a message
local function force_close_buffer(buffer_number, message)
  vim.cmd('bdelete! ' .. buffer_number)
  vim.api.nvim_echo({{message, 'InfoMsg'}}, false, {})
end

-- Switch to the previous buffer
local function switch_buffer()
  if vim.fn.bufnr('#') ~= -1 and vim.fn.bufloaded(vim.fn.bufnr('#')) then
    vim.cmd('buffer #') -- Switch to alternate buffer
    return
  end
  vim.cmd('bprevious') -- Switch to the previous buffer in list
end

-- Close current buffer after switching
local function close_current_buffer(message)
  local buffers = vim.fn.getbufinfo({buflisted = 1})
  if #buffers > 1 then
    switch_buffer()
    force_close_buffer('#', message)
    return
  end
  force_close_buffer('%', message)
end

-- Main function to close the buffer with proper prompts for unsaved changes
function M.close_buffer()
  local SAVE_OPTION = 'y'
  local DONT_SAVE_OPTION = 'n'
  local CANCEL_OPTION = 'c'

  local UNSAVED_CHANGES_PROMPT = "Current buffer has unsaved changes. Do you want to save it? [y]es, [n]o, [C]ancel: "
  local ENTER_FILE_NAME_PROMPT = "Enter a name for the new file (leave blank to discard changes): "
  local SAVED_AND_CLOSED_MSG = " saved and closed."
  local CLOSED_WITHOUT_SAVING_MSG = " closed without saving."
  local CLOSED_MSG = " closed."
  local CLOSE_CANCELED_MSG = "Buffer close canceled."

  local current_buf = vim.fn.bufnr('%')
  local current_buf_name = vim.fn.bufname(current_buf)
  if current_buf_name == '' then
    current_buf_name = '[Unnamed]'
  end

  -- If buffer is not modified, close it immediately
  if not is_buffer_modified(current_buf) then
    close_current_buffer(current_buf_name .. CLOSED_MSG)
    return
  end

  -- Buffer has unsaved changes, prompt user
  vim.api.nvim_echo({{UNSAVED_CHANGES_PROMPT, 'None'}}, false, {})
  local choice = string.lower(vim.fn.nr2char(vim.fn.getchar()))

  -- Handle Save and Close
  if choice == SAVE_OPTION then
    if current_buf_name == '[Unnamed]' then
      -- Prompt for file name if buffer is unnamed
      vim.api.nvim_echo({{ENTER_FILE_NAME_PROMPT, 'None'}}, false, {})
      local file_name = vim.fn.input('')

      if file_name ~= '' then
        vim.cmd('write ' .. file_name)
        close_current_buffer(file_name .. SAVED_AND_CLOSED_MSG)
        return
      end

      -- No name provided, discard changes and close
      close_current_buffer(current_buf_name .. CLOSED_WITHOUT_SAVING_MSG)
      return
    end

    -- Save and close the named buffer
    vim.cmd('write')
    close_current_buffer(current_buf_name .. SAVED_AND_CLOSED_MSG)
    return
  end

  -- Handle Discard and Close
  if choice == DONT_SAVE_OPTION then
    close_current_buffer(current_buf_name .. CLOSED_WITHOUT_SAVING_MSG)
    return
  end

  -- Handle Cancel
  vim.api.nvim_echo({{CLOSE_CANCELED_MSG, 'InfoMsg'}}, false, {})
end

-- Command to trigger the CloseBuffer function
vim.api.nvim_create_user_command('CloseBuffer', M.close_buffer, {})

return M
