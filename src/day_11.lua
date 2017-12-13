local utils = require 'utils'
local math  = require 'math'


local function get_direction_coords()
  return {
    n  = { x =  0, y =  2, },
    ne = { x =  2, y =  1, },
    se = { x =  2, y = -1, },
    s  = { x =  0, y = -2, },
    sw = { x = -2, y = -1, },
    nw = { x = -2, y =  1, }
  }
end

local function get_return_direction(x, y)
  if x == 0 and y > 0 then
    return 's'
  elseif x == 0 and y < 0 then
    return 'n'
  elseif x > 0 and y > 0 then
    return 'sw'
  elseif x > 0 and y <= 0 then
    return 'nw'
  elseif x < 0 and y < 0 then
    return 'ne'
  elseif x < 0 and y >= 0 then
    return 'se'
  end
end

local function get_steps_to_center(x, y)
  local coords = get_direction_coords()
  local steps  = 0

  while x ~= 0 or y ~= 0 do
    local r_dir = get_return_direction(x, y)

    x = x + coords[r_dir]['x']
    y = y + coords[r_dir]['y']

    steps = steps + 1
  end

  return steps
end

local function part_1(input)
  local coords = get_direction_coords()
  local x, y   = 0, 0

  for k, v in ipairs(utils.split(input, ',')) do
    x = x + coords[v]['x']
    y = y + coords[v]['y']
  end

  return get_steps_to_center(x, y)
end

local function part_2(input)
  local coords = get_direction_coords()
  local x, y, max_steps = 0, 0, 0

  for k, v in ipairs(utils.split(input, ',')) do
    x = x + coords[v]['x']
    y = y + coords[v]['y']

    local ms = get_steps_to_center(x, y)
    if ms > max_steps then max_steps = ms end
  end

  return max_steps
end


local input = utils.read_file('../res/day_11.in')

print('Steps (part 1):', part_1(input))
print('Steps (part 2):', part_2(input))
