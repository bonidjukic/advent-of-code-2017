local _M = {}

function _M.split(str, sep)
  local result = {}
  local i = 1

  for s in string.gmatch(str, '([^' .. sep .. ']+)') do
    result[i] = s
    i = i + 1
  end

  return result
end

function _M.read_file(path)
  local f = assert(io.open(path, 'r'))
  local c = f:read('*all')
  f:close()
  return c
end

function _M.sort_string(str)
  local t = {}

  for i = 1, #str do
    t[i] = str:sub(i, i)
  end

  table.sort(t)

  return table.concat(t)
end

function _M.t_max_pos(t)
  local max, pos = t[1], 1

  for k, v in ipairs(t) do
    if v > max then
      max = v
      pos = k
    end
  end

  return max, pos
end

return _M
