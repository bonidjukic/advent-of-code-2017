local utils = require 'utils'


local function get_tree(input)
  local tree = {}

  for _, p in ipairs(utils.split(input, '\n')) do
    -- row program line
    local row_p = utils.split(p, '->')

    -- left side program
    local pl = utils.split(row_p[1], ' ')
     -- left side program value
    local pl_v = pl[1]
    -- left side program weight
    local pl_w = pl[2]:gsub('%(', ''):gsub('%)', '')

    if not tree[pl_v] then
      tree[pl_v] = {
        value  = pl_v,
        weight = pl_w
      }
    else
      tree[pl_v]['value']  = pl_v
      tree[pl_v]['weight'] = pl_w
    end

    -- if there a right side of the program,
    -- parse it and set the parent information
    if row_p[2] then
      local children = utils.split(utils.trim(row_p[2]), ', ')
      for _, v in ipairs(children) do
        -- save the parents
        if not tree[v] then
          tree[v] = {
            parent = pl_v
          }
        else
          tree[v]['parent'] = pl_v
        end

        -- save the children
        if not tree[pl_v]['children'] then
          tree[pl_v]['children'] = {}
        end
        table.insert(tree[pl_v]['children'], v)
      end
    end
  end

  return tree
end

local function get_root(tree)
  -- the root of the tree is the node
  -- which doesn't have a parent
  for _, v in pairs(tree) do
    if not v['parent'] then return v['value'] end
  end
end

local function get_node_children(node, tree)
  local children = {}

  for _, v in pairs(tree) do
    if v['parent'] == node then
      children[#children + 1] = v['value']
    end
  end

  return children
end

local function get_branch_sum(root, tree)
  local sum = 0

  local function recur(n)
    sum = sum + tree[n]['weight']
    for _, v in ipairs(get_node_children(n, tree)) do
      recur(v)
    end
  end

  recur(root)

  return sum
end

local function get_unb_node_and_sums(root, tree)
  local unb_s
  local unb_n = root

  local function recur(n)
    local sums = {}
    local children = get_node_children(n, tree)

    for _, v in ipairs(children) do
      local s = get_branch_sum(v, tree)

      if sums[s] then
        sums[s]['count'] = sums[s]['count'] + 1
      else
        sums[s] = {
          count = 1,
          node  = v
        }
      end
    end

    for _, v in pairs(sums) do
      if v['count'] == 1 and utils.t_keys_cnt(sums) > 1 then
        -- save the node and sums information for later
        unb_n = v['node']
        unb_s = utils.t_copy(sums)
      end
    end

    -- continue the recursion to check the children
    for _, v in ipairs(children) do
      recur(v)
    end

  end

  -- trigger recursion with the root node
  recur(root)

  return unb_n, unb_s
end

local function part1(input)
  return get_root(get_tree(input))
end

local function part2(input)
  local tree = get_tree(input)

  local unb_n, unb_s = get_unb_node_and_sums(
    get_root(tree), tree
  )

  local ms, ss -- multiple sums and single sum
  for k, v in pairs(unb_s) do
    if v['count'] == 1 then ss = k
    else ms = k end
  end

  -- result is the weight of the unbalanced node
  -- minues the difference of the multiple sums
  -- and the single sum, i.e. the weight required
  -- to balance the unbalanced node
  return tree[unb_n]['weight'] + (ms - ss)
end


local input = utils.read_file('../res/day_07.in')

print('Bottom program (part 1):', part1(input))
print('Weight (part 2):', part2(input))
