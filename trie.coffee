curry = (arg, fun, arity) ->
  return (args...) -> fun(arg, args...)

Node = (left, right) ->
  0: left
  1: right

nodeWithDepth = (depth) ->
  if depth == 1
    Node()
  else
    node = nodeWithDepth(depth - 1)
    Node(node, node)

updatedNode = (node, key, value, depth) ->
  if depth == 0
    value
  else if key & (1 << (depth - 1))
    Node(node[0], updatedNode(node[1], key, value, depth - 1))
  else
    Node(updatedNode(node[0], key, value, depth - 1), node[1])

getNode = (node, key, depth) ->
  if depth == 1
    node[key & 1]
  else if key & (1 << depth - 1)
    getNode(node[1], key, depth - 1)
  else
    getNode(node[0], key, depth - 1)

Trie = (depth, root, size, offset) ->
  depth ||= 1
  root ||= nodeWithDepth(depth)
  size ||= 0
  offset ||= 0
  self =
    depth: depth
    root: root
    size: -> size
    offset: offset
  self.push = curry(self, push, 2)
  self.pop = curry(self, pop, 1)
  self.set = curry(self, set, 3)
  self.get = curry(self, get, 2)
  self.shift = curry(self, shift, 1)
  self.toArray = curry(self, toArray, 1)
  self

empty = -> Trie()

set = (trie, index, value) ->
  newOffset = Math.min(trie.offset, index)
  newSize = Math.max(trie.size(), index + 1) + trie.offset - newOffset
  if index >= (1 << trie.depth)
    set(Trie(trie.depth + 1, Node(trie.root, nodeWithDepth(trie.depth)), newSize, newOffset), index, value)
  else
    Trie(trie.depth, updatedNode(trie.root, index, value, trie.depth), newSize, newOffset)

get = (trie, index) ->
  getNode(trie.root, index + trie.offset, trie.depth)

push = (trie, value) ->
  set(trie, trie.size() + trie.offset, value)

pop = (trie) ->
  if trie.size() == 0
    trie
  else if (trie.size() - 1) <= (1 << (trie.depth - 1)) && trie.depth > 1
    Trie(trie.depth - 1, trie.root[0], trie.size() - 1, trie.offset)
  else
    Trie(trie.depth, updatedNode(trie.root, trie.size() - 1, undefined, trie.depth), trie.size() - 1, trie.offset)

shift = (trie) ->
  if trie.size() == 0
    trie
  else if trie.offset + 1 >= (1 << (trie.depth - 1)) && trie.depth > 1
    Trie(trie.depth - 1, trie.root[1], trie.size() - 1, 0)
  else
    Trie(trie.depth, updatedNode(trie.root, trie.offset, undefined, trie.depth), trie.size() - 1, trie.offset + 1)

size = (trie) -> trie.size()

toArray = (trie) ->
  (trie.get(i) for i in [0...trie.size()])

module.exports =
  empty: empty
