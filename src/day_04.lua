local utils = require 'utils'


-- part 1
local function part1(input)
  local cnt = 0
  local passphrases = utils.split(input, '\n')

  for _, passphrase in ipairs(passphrases) do
    local t = {}
    local duplicate = false

    for _, w in ipairs(utils.split(passphrase, ' ')) do
      if t[w] then
        duplicate = true
        break
      end

      t[w] = true
    end

    if not duplicate then
      cnt = cnt + 1
    end
  end

  return cnt
end

local input = utils.read_file('../res/day_04.in')

print('Valid passphrases count:', part1(input))
