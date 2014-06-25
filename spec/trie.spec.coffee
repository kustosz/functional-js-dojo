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

describe 'push', ->
  beforeEach ->
    @array = trie.empty().set(5, "value")
    @res = trie.push(@array, 10)

  it 'appends element as the last in the structure', ->
    expect(trie.get(@res, 6)).toEqual(10)

  it 'updates structure size', ->
    expect(trie.size(@res)).toEqual(7)
    expect(trie.size(@array)).toEqual(6)

describe 'pop', ->
  beforeEach ->
    @array = trie.empty().set(5, "val1").set(6, "val2")
    @res = trie.pop(@array)

  it 'removes the last element in the structure', ->
    expect(trie.get(@res, 6)).not.toBeDefined()
    expect(trie.get(@array, 6)).toEqual("val2")

  it 'updates structure size', ->
    expect(trie.size(@res)).toEqual(6)
    expect(trie.size(@array)).toEqual(7)

