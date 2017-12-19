local utils = require 'utils'


local function parse(input)
  local ps = {}

  for _, line in ipairs(utils.split(input, '\n')) do
    local split = utils.split(line, '<-')
    local lpid  = tonumber(utils.trim(split[1]))
    local rpids = split[2]:gsub('> ', '')

    ps[lpid] = {}
    for _, pid in ipairs(utils.split(rpids, ', ')) do
      ps[lpid][#ps[lpid] + 1] = tonumber(pid)
    end
  end

  return ps
end

local function part_1(input, pid)
  local input = parse(input)
  local group = {}
  local recur

  recur = function(pid)
    for _, p in ipairs(input[pid]) do
      if not group[p] then
        group[p] = true
        recur(p)
      end
    end
  end

  recur(pid)

  return utils.t_keys_cnt(group)
end

local function part_2(input)
  local input   = parse(input)
  local groups  = {}
  local visited = {}
  local recur

  recur = function(pid, group)
    -- log visited pid's
    visited[pid] = true

    for _, p in ipairs(input[pid]) do
      if not group[p] then
        group[p] = true
        recur(p, group)
      end
    end
  end

  for lpid, rpids in pairs(input) do
    -- skip already visited pid's
    if not visited[lpid] then
      groups[lpid] = {}
      recur(lpid, groups[lpid])
    end
  end

  return utils.t_keys_cnt(groups)
end


local input = utils.read_file('../res/day_12.in')

print('Programs - pid=0 (part 1):', part_1(input, 0))
print('Groups (part 2):', part_2(input))
