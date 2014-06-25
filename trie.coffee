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

Trie = (depth, root, size) ->
  depth ||= 1
  root ||= nodeWithDepth(depth)
  size ||= 0
  self =
    depth: depth
    root: root
    size: () -> size
  self.push = curry(self, push, 2)
  self.pop = curry(self, pop, 1)
  self.set = curry(self, set, 3)
  self.get = curry(self, get, 2)
  self

empty = -> Trie()

set = (trie, index, value) ->
  newSize = Math.max(trie.size(), index + 1)
  if index >= (1 << trie.depth)
    set(Trie(trie.depth + 1, Node(trie.root, nodeWithDepth(trie.depth)), newSize), index, value)
  else
    Trie(trie.depth, updatedNode(trie.root, index, value, trie.depth), newSize)

get = (trie, index) ->
  getNode(trie.root, index, trie.depth)

push = (trie, value) ->
  set(trie, trie.size(), value)

pop = (trie) ->
  if trie.size() == 0
    trie
  else if (trie.size() - 1) <= (1 << (trie.depth - 1)) && trie.depth > 1
    Trie(trie.depth - 1, trie.root[0], trie.size() - 1)
  else
    Trie(trie.depth, updatedNode(trie.root, trie.size() - 1, undefined, trie.depth), trie.size() - 1)

size = (trie) -> trie.size()

module.exports =
  empty: empty
  set: set
  get: get
  push: push
  pop: pop
  size: size
