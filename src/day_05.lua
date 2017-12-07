local utils = require 'utils'


local function get_increment_value(args)
  if args.part == 1 then
    return 1
  else
    return args.value < 3 and 1 or -1
  end
end

local function get_steps(args)
  local t = utils.split(args.input, '\n')

  local pos = 1
  local steps = 0

  while pos > 0 and pos <= #t do
    curr_pos = pos
    curr_val = tonumber(t[pos])

    pos = pos + curr_val

    if t[pos] then
      local incr = get_increment_value {
        value = curr_val,
        part = args.part
      }

      t[curr_pos] = t[curr_pos] + incr
      steps = steps + 1
    else
      return steps + 1
    end
  end

  return
end


local input = utils.read_file('../res/day_05.in')

print('Steps (part 1):', get_steps { input = input, part = 1 })
print('Steps (part 2):', get_steps { input = input, part = 2 })