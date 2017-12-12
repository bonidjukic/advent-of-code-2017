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

function _M.trim(str)
  return (str:gsub("^%s*(.-)%s*$", "%1"))
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

function _M.t_keys_cnt(t)
  local cnt = 0
  for _ in pairs(t) do cnt = cnt + 1 end
  return cnt
end

function _M.t_copy(t)
  local cp = {}
  for k, v in pairs(t) do cp[k] = v end
  return setmetatable(cp, getmetatable(t))
end

function _M.t_reverse(t)
  local rev = {}
  for k, v in ipairs(t) do
    rev[#t + 1 - k] = v
  end

  return rev
end

return _M
