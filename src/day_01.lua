local utils = require 'utils'


-- part 1
local function part1(input)
  local sum = 0

  for i = 1, #input do
    local curr_val, next_val, p

    curr_val = input:sub(i, i)
    p = (i == #input) and 1
                       or i + 1
    next_val = input:sub(p, p)

    if curr_val == next_val then
      sum = sum + tonumber(curr_val)
    end
  end

  return sum
end

-- part 2
local function part2(input)
  local steps = #input / 2
  local sum = 0

  for i = 1, #input do
    local curr_val, next_val, p

    curr_val = input:sub(i, i)
    p = (#input - i >= steps) and i + steps
                               or steps - (#input - i)
    next_val = input:sub(p, p)

    if curr_val == next_val then
      sum = sum + tonumber(curr_val)
    end
  end

  return sum
end


local input = utils.read_file('../res/day_01.in')

print('Part 1:', part1(input))
print('Part 2:', part2(input))
