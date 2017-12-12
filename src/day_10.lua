local utils = require 'utils'
local bit32 = require 'bit32'


local function process_input_p1(input)
  return utils.split(input, ',')
end

local function part_1(input)
  local length_seq = process_input_p1(input)

  -- generate the list of size 256 (0 to 255)
  local t = {}
  for i = 0, 255 do t[#t + 1] = i end

  local t_len = #t
  local pos   = 1
  local skip  = 0

  for _, length in ipairs(length_seq) do
    local rev_t, rev_pos, res_t = {}, {}, {}
    local offset = 0

    -- get the sub-table which needs to be rotated
    for i = pos, pos + length - 1 do
      offset = i % t_len
      if offset == 0 then offset = t_len end

      -- insert numbers in the sub-table to reverse
      rev_t[#rev_t + 1] = t[offset]
      -- remember the offset positions to that we
      -- know where to insert after we've reversed
      rev_pos[#rev_pos + 1] = offset
    end

    -- reverse the sub-table
    rev_t = utils.t_reverse(rev_t)

    -- insert reversed numbers into their places
    -- according to the offset table we keps
    for k, v in ipairs(rev_pos) do
      res_t[v] = rev_t[k]
    end

    -- finally, just place the rest of the numbers
    -- where they belong
    for i = offset + 1, offset + (t_len - length) do
      offset = i % t_len
      if offset == 0 then offset = t_len end

      res_t[offset] = t[offset]
    end

    -- increase position and skip values
    -- as per the challenge instructions
    pos  = pos + length + skip
    skip = skip + 1
    t    = res_t
  end

  return t[1] * t[2]
end

local function process_input_p2(input)
  local r = {}

  for i = 1, #input do
    r[#r + 1] = string.byte(input:sub(i, i))
  end

  local suffix_values = { 17, 31, 73, 47, 23 }
  for _, v in ipairs(suffix_values) do
    r[#r + 1] = v
  end

  return r
end

local function part_2(input)
  local length_seq = process_input_p2(input)
  local t = {}

  do
    -- generate the list of size 256 (0 to 255)
    for i = 0, 255 do t[#t + 1] = i end

    local t_len = #t
    local pos   = 1
    local skip  = 0

    for round = 1, 64 do
      for _, length in ipairs(length_seq) do
        local rev_t, rev_pos, res_t = {}, {}, {}
        local offset = 0

        -- get the sub-table which needs to be rotated
        for i = pos, pos + length - 1 do
          offset = i % t_len
          if offset == 0 then offset = t_len end

          -- insert numbers in the sub-table to reverse
          rev_t[#rev_t + 1] = t[offset]
          -- remember the offset positions to that we
          -- know where to insert after we've reversed
          rev_pos[#rev_pos + 1] = offset
        end

        -- reverse the sub-table
        rev_t = utils.t_reverse(rev_t)

        -- insert reversed numbers into their places
        -- according to the offset table we keps
        for k, v in ipairs(rev_pos) do
          res_t[v] = rev_t[k]
        end

        -- finally, just place the rest of the numbers
        -- where they belong
        for i = offset + 1, offset + (t_len - length) do
          offset = i % t_len
          if offset == 0 then offset = t_len end

          res_t[offset] = t[offset]
        end

        -- increase position and skip values
        -- as per the challenge instructions
        pos  = pos + length + skip
        skip = skip + 1
        t    = res_t
      end
    end
  end

  local hash = {}

  do
    local dense_hash  = {}

    for i = 1, 16 do
      local bxor = 0

      for j = 1, 16 do
        local idx = ((i - 1) * 16) + j
        bxor = bit32.bxor(bxor, t[idx]) -- t = sparse hash
      end

      dense_hash[#dense_hash + 1] = bxor
    end

    for _, v in ipairs(dense_hash) do
      hash[#hash + 1] = string.format('%02x', v)
    end
  end

  return table.concat(hash)
end


local input = '94,84,0,79,2,27,81,1,123,93,218,23,103,255,254,243'

print('Result (part 1):', part_1(input))
print('Result (part 2):', part_2(input))
