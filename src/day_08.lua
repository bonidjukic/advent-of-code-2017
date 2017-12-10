local math  = require 'math'
local utils = require 'utils'


local function get_registers_and_instructions(input)
  local registers    = {}
  local instructions = {}

  for _, r in ipairs(utils.split(input, '\n')) do
    local r_line = utils.split(r, ' ')

    -- add unique registers and initialize
    -- their values to 0
    registers[r_line[1]] = 0

    -- save structured instructions
    table.insert(instructions, {
      reg     =          r_line[1],  -- register
      act     =          r_line[2],  -- action
      val     = tonumber(r_line[3]), -- value
      cnd_reg =          r_line[5],  -- condition register
      cnd_opr =          r_line[6],  -- condition operator
      cnd_val = tonumber(r_line[7])  -- condition value
    })
  end

  return registers, instructions
end

local function condition_true(op_a, op_b, op)
  if     op == '>'  then return op_a >  op_b
  elseif op == '>=' then return op_a >= op_b
  elseif op == '<'  then return op_a <  op_b
  elseif op == '<=' then return op_a <= op_b
  elseif op == '==' then return op_a == op_b
  elseif op == '!=' then return op_a ~= op_b end
end

local function get_maximums(input)
  local registers, instructions = get_registers_and_instructions(input)

  local max_r_any = -math.huge

  for k, v in pairs(instructions) do
    local op_a = registers[v['cnd_reg']]
    local op_b = v['cnd_val']
    local op   = v['cnd_opr']

    if condition_true(op_a, op_b, op) then
      local incr = (v['act'] == 'dec') and -v['val']
                                        or  v['val']

      local new_val = registers[v['reg']] + incr

      -- set new register value
      registers[v['reg']] = new_val

      -- make sure to save the highest value held
      -- in any register during the process
      if new_val > max_r_any then
        max_r_any = new_val
      end
    end
  end

  -- look for the register with the highest value
  local max_r = -math.huge
  for _, v in pairs(registers) do
    if v > max_r then max_r = v end
  end

  return max_r, max_r_any
end


local input = utils.read_file('../res/day_08.in')
local max_r, max_r_any = get_maximums(input)

print('Largest value (part 1):', max_r)
print('Largest value ever (part 2):', max_r_any)
