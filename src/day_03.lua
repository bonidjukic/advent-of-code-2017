local math = require 'math'

-- part 1
local function part1(n)
  -- find the closest square root of the n
  local tr_diagonal = math.ceil(math.sqrt(n))
  -- if the n is an even number, convert it to an uneven one
  if tr_diagonal % 2 == 0 then
    tr_diagonal = tr_diagonal + 1
  end

  -- begin with the triangle with largest values and move
  -- down if the n is not located within that triangle
  local tr_angle_val = tr_diagonal ^ 2
  while (tr_angle_val - n) - (tr_diagonal - 1) > 0 do
    tr_angle_val = tr_angle_val - (tr_diagonal - 1)
  end

  -- find the middle of the square side / triangle diagonal
  local middle = math.floor(tr_diagonal / 2)

  -- the final number of steps can be calculated by adding
  -- the distance from the middle to the location of the n
  -- and the distance from the middle to the center of the grid
  local middle_to_n_dist = math.abs(middle - (tr_angle_val - n ))
  local middle_to_c_dist = (tr_diagonal - 1) / 2

  return middle_to_n_dist + middle_to_c_dist
end

-- part 2
local function part2(n)
  local mt = {}

  -- set the first / center value
  mt[0] = {}
  mt[0][0] = 1

  -- because of the tables simetry the first
  -- coordinate is y, and the second one is x

  -- steps order
  local steps = {
    {  0,  1 }, -- right
    {  1,  0 }, -- up
    {  0, -1 }, -- left
    { -1,  0 }  -- down
  }

  -- define the coordinates of the 8 neighbours
  local neighbours = {
    {  0,  1 }, -- E
    {  1,  1 }, -- NE
    {  1,  0 }, -- N
    {  1, -1 }, -- NW
    {  0, -1 }, -- W
    { -1, -1 }, -- SW
    { -1,  0 }, -- S
    { -1,  1 }  -- SE
  }

  local step_pos = 0
  local step_rep = 0

  local x = 0
  local y = 0

  for i = 1, math.huge do

    -- we're going to move based on the
    -- following scheme:
    --
    -- 1 R + 1 U
    -- 2 L + 2 D
    -- 3 R + 3 U
    -- 4 L + 4 D
    -- 5 R + 5 U
    -- ...

    -- increase the number of times we
    -- move in each direction
    step_pos = step_pos + 1
    -- make sure we always move twice for
    -- a single `step_pos` value
    step_rep = step_rep + 0.5

    for j = 1, math.ceil(step_rep) do
      y = y + steps[step_pos][1]
      x = x + steps[step_pos][2]

      -- create sub-table for this particular
      -- y position if necessary
      if not mt[y] then mt[y] = {} end

      -- sum the neighbours
      local n_sum = 0
      for _, n_v in ipairs(neighbours) do
        local n_y = y + n_v[1]
        local n_x = x + n_v[2]

        if mt[n_y] and mt[n_y][n_x] then
          n_sum = n_sum + mt[n_y][n_x]
        end
      end

      -- set the neighbours sum value
      mt[y][x] = n_sum

      -- end the calculation if the neighbours sum
      -- is larger than the specified input value
      if n_sum > n then
        return n_sum
      end
    end

    -- rotate steps
    if step_pos == 4 then
      step_pos = 0
    end
  end

  return n_sum
end


local input = 347991

print('Part 1:', part1(input))
print('Part 2:', part2(input))
