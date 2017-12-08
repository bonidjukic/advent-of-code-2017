local utils = require 'utils'


local function get_steps_and_loops(input)
  local loops
  local steps = 0

  local ls = {} -- loops table
  local cs = {} -- cycles table

  local c = table.concat(input) -- cycle string

  cs[c] = 1 -- insert the given input manually
  ls[c] = 0 -- set the loop count manually

  while cs[c] <= 1 do
    -- call utility function which return the
    -- maximum table value and it's index / position
    local max, max_pos = utils.t_max_pos(input)

    -- reset current position
    input[max_pos] = 0

    -- loop over for `max` times and increase values by one
    for i = max_pos + 1, max_pos + max do
      local offset = i % #input

      -- if the offset is 0 it's the end of the table
      if offset == 0 then
        offset = #input
      end

      input[offset] = input[offset] + 1
    end

    -- save current cycle combination
    c = table.concat(input)
    cs[c] = cs[c] and (cs[c] + 1) or 1

    if ls[c] then
      loops = steps - ls[c]
    else
      ls[c] = steps
    end

    -- increase steps count
    steps = steps + 1
  end

  return steps, loops
end


local input = { 10, 3, 15, 10, 5, 15, 5, 15, 9, 2, 5, 8, 5, 2, 3, 6 }

local steps, loops = get_steps_and_loops(input)
print('Steps (part 1):', steps)
print('Loops (part 2):', loops)