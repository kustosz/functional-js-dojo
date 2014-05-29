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
  depth: depth
  root: root
  size: size
empty = -> Trie()

set = (trie, index, value) ->
  newSize = Math.max(trie.size, index + 1)
  if index >= (1 << trie.depth)
    set(Trie(trie.depth + 1, Node(trie.root, nodeWithDepth(trie.depth)), newSize), index, value)
  else
    Trie(trie.depth, updatedNode(trie.root, index, value, trie.depth), newSize)

get = (trie, index) ->
  getNode(trie.root, index, trie.depth)

size = (trie) -> trie.size

module.exports =
  empty: empty
  set: set
  get: get
  size: size
