#= require base_helper

QUnit.module 'Expect'
  setup: ->
    class @Foo
      bar: (msg, q=1)=>
        _msg = msg.toUpperCase()
        msg = ""
        for i in [0...q]
          msg += _msg
        msg

      chunky: =>
        @bacon ||= 'crunchy!'
        @bacon += ' crunchy!'

      toString: => "[Foo]"
    @foo = new @Foo


test "meets chained expectations", ->
  expect 6
  e = expect(@foo, 'bar').with('chunky').toReturn('CHUNKY')
  @foo.bar 'chunky'
  e.assertExpectationsMet()

  e = expect(@foo, 'bar').with(undefined, 2).with('Chunky')
  @foo.bar 'Bacon', 2
  @foo.bar 'Chunky'
  e.assertExpectationsMet()

test "assertExpectationsMet accepts expections hash", ->
  expect 6
  e = expect(@foo, 'bar')
  @foo.bar 'chunky'
  @foo.bar 'bacon', 3
  e.assertExpectationsMet
    calls: 2
    with: [['chunky'], ['bacon', 3]]
    toReturn: ['CHUNKY', 'BACONBACONBACON']

test "works with class instance methods", ->
  expect 7
  e = expect(@foo, 'chunky').with('bacon').toReturn('crunchy! crunchy!').toReturn('crunchy! crunchy! crunchy!')
  @foo.chunky 'bacon'
  @foo.chunky()
  e.assertExpectationsMet()

  h = {
    fn: ->
      this.foo ||= 1
      this.foo += 1
    toString: -> 'h'
  }
  e = expect(h, 'fn').toReturn(2).toReturn(3)
  h.fn()
  h.fn()
  e.assertExpectationsMet()

QUnit.module 'Stub'
  setup: ->
    @chunky = {
      bacon: ->
        'crunchy!'
    }

test "stubs and unstubs", ->
  equal @chunky.bacon(), 'crunchy!', 'original'

  stub @chunky, 'bacon', ->
    'crunchy breakfast!'
  equal @chunky.bacon(), 'crunchy breakfast!', 'stubs'

  @chunky.__unstub__()
  equal @chunky.bacon(), 'crunchy!', 'unstubs'

QUnit.module 'Mock'
  setup: ->
    @chunky = {
      bacon: -> 'crunchy!!'
      toString: -> 'Chunky'
    }

test "mock expects to be called", ->
  expect 2
  m = mock @chunky, 'bacon', (-> 'breakfast!')
  equal @chunky.bacon(), 'breakfast!', 'chunky.bacon() == breakfast!'
  m.assertExpectationsMet()

