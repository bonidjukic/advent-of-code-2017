local math = require 'math'


local function get_steps(n)
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


local input = 347991
print('Steps:', get_steps(input))
