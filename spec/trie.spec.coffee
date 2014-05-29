trie = require('../trie.coffee')

describe 'set and get', ->
  beforeEach ->
    @array = trie.empty()
    @res = trie.set(@array, 7, "value")

  it 'sets given index to value', ->
    expect(trie.get(@res, 7)).toEqual("value")

  it 'does not modify the original structure', ->
    expect(trie.get(@array, 7)).not.toBeDefined()

  it 'sets proper structure size', ->
    expect(trie.size(@array)).toEqual(0)
    expect(trie.size(@res)).toEqual(8)

