local utils = require 'utils'


local function process_word(args)
  -- the logic for the first and the second part
  -- is the same with the exception that we have
  -- to sort the string in part 2
  return args.part == 2 and utils.sort_string(args.word)
                         or args.word
end

local function get_valid_count(args)
  local cnt = 0
  local passphrases = utils.split(args.input, '\n')

  for _, passphrase in ipairs(passphrases) do
    local t = {}
    local duplicate = false

    for _, w in ipairs(utils.split(passphrase, ' ')) do
      local word = process_word { word = w,
                                  part = args.part }
      if t[word] then
        duplicate = true
        break
      end

      t[word] = true
    end

    if not duplicate then
      cnt = cnt + 1
    end
  end

  return cnt
end


local input = utils.read_file('../res/day_04.in')

print('Valid passphrases count (part 1):',
      get_valid_count { input = input, part = 1 })

print('Valid passphrases count (part 2):',
      get_valid_count { input = input, part = 2 })
