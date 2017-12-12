local utils = require 'utils'


local function clean(input)
  -- remove all "!*" instances
  clean = input:gsub('(!.)', '')

  -- remove the garbage
  local garbage = false
  local tmp_clean = {}

  for i = 1, #clean do
    local char = clean:sub(i, i)

    if char == '<' then
      garbage = true
    elseif char == '>' then
      garbage = false
    elseif not garbage then
      tmp_clean[#tmp_clean + 1] = char
    end
  end

  return table.concat(tmp_clean)
end

local function get_score(input)
  local score  = 0
  local weight = 1

  local clean = clean(input)

  for i = 1, #clean do
    local char = clean:sub(i, i)

     if char == '{' then
      score  = score + weight
      weight = weight + 1
    end

    if char == '}' then
      weight = weight - 1
    end

  end

  return score
end

local function get_garbage_chars(input)
  -- remove all "!*" instances
  clean = input:gsub('(!.)', '')

  local garbage = false
  local cnt     = 0

  for i = 1, #clean do
    local char = clean:sub(i, i)

    if not garbage and char == '<' then
      garbage = true
    elseif char == '>' then
      garbage = false
    elseif garbage then
      cnt = cnt + 1
    end
  end

  return cnt
end

local input = utils.read_file('../res/day_09.in')

print('Total score (part 1):', get_score(input))
print('Total chars (part 2):', get_garbage_chars(input))