trie = require('../trie.coffee')

describe 'set and get', ->
  beforeEach ->
    @array = trie.empty()
    @res = @array.set(7, "value")

  it 'sets given index to value', ->
    expect(@res.get(7)).toEqual("value")

  it 'does not modify the original structure', ->
    expect(@array.get(7)).not.toBeDefined()

  it 'sets proper structure size', ->
    expect(@array.size()).toEqual(0)
    expect(@res.size()).toEqual(8)

describe 'push', ->
  beforeEach ->
    @array = trie.empty().set(5, "value")
    @res = @array.push(10)

  it 'appends element as the last in the structure', ->
    expect(@res.get(6)).toEqual(10)

  it 'updates structure size', ->
    expect(@res.size()).toEqual(7)
    expect(@array.size()).toEqual(6)

describe 'pop', ->
  beforeEach ->
    @array = trie.empty().set(5, "val1").set(6, "val2")
    @res = @array.pop()

  it 'removes the last element in the structure', ->
    expect(@res.get(6)).not.toBeDefined()
    expect(@array.get(6)).toEqual("val2")

  it 'updates structure size', ->
    expect(@array.size()).toEqual(7)
    expect(@res.size()).toEqual(6)

describe 'shift', ->
  beforeEach ->
    @array = trie.empty().push(1).push(2).push(3).push(4).push(5)
    @res = @array.shift()

  it 'removes first element from the structure', ->
    expect(@array.get(0)).toEqual(1)
    expect(@res.get(0)).toEqual(2)

  it 'updates structure size', ->
    expect(@array.size()).toEqual(5)
    expect(@res.size()).toEqual(4)

describe 'toArray', ->
  it 'dumps trie contents to array', ->
    ary = trie.empty().push(1).push(2).push(3).push(4).push(5)
    expect(ary.toArray()).toEqual([1, 2, 3, 4, 5])

