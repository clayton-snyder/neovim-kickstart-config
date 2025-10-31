local util = {}

function util.is_windows()
  return vim.fn.has('win64') == 1 or vim.fn.has('win32') == 1 or vim.fn.has('win16') == 1
end

-- Changes path separators to backslashes if on Windows and forward slashes if not.
function util.fix_filepath(path_str)
  if util.is_windows() then
    return string.gsub(path_str, '/', '\\')
  end
  
  return string.gsub(path_str, '\\', '/')
end

return util
