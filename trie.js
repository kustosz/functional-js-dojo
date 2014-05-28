var Node = function (left, right) {
  return {
    0: left,
    1: right
  };
};

var nodeWithDepth = function (depth) {
  if (depth === 1) return Node();
  node = nodeWithDepth(depth - 1);
  return Node(node, node);
}

var updatedNode = function (node, key, value, depth) {
  if (depth === 0) return value;
  if (key & (1 << (depth - 1))) return Node(node[0], updatedNode(node[1], key, value, depth - 1));
  return Node(updatedNode(node[0], key, value, depth - 1), node[1]);
}

var getNode = function (node, key, depth) {
  if (depth == 1) return node[key & 1];
  if (key & (1 << (depth - 1))) return getNode(node[1], key, depth - 1);
  return getNode(node[0], key, depth - 1);
}

var Trie = function (depth, root) {
  if (!depth) return Trie(1);
  if (!root) return Trie(depth, nodeWithDepth(depth));
  return {
    depth: depth,
    root: root
  };
};

var set = function (trie, index, value) {
  if (index >= (1 << trie.depth))
    return set(Trie(trie.depth + 1, Node(trie.root, nodeWithDepth(trie.depth))), index, value);
  return Trie(trie.depth, updatedNode(trie.root, index, value, trie.depth));
}

var get = function (trie, index) {
  return getNode(trie.root, index, trie.depth);
}
