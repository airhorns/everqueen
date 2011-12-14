## Mocha-inspired helpers for QUnit
#
# e = expect(object, 'method')                     : expects object.method 1x
# e = expect(object, 'method').with('bacon')       : expects object.method('bacon') 1x
# e = expect(obj, 'me').with(undefined, 3)         : expects obj.me with 2nd arg == 3 (ignore 1st arg) 1x
# e = expect(object, 'method').toReturn('foo')     : expects object.method to return 'foo' 1x
# e = expect(obj, 'me').with('arg').toReturn('re') : expects obj.me('arg') to return 're' 1x
# e.assertExpectationsMet()                        : asserts expectations
# e.assertExpectationsMet({ calls  : 3 })          : asserts called 3x
#
# expect 6 still means 6 assertions are expected
#
# Stub
# obj = {
#   me: -> 'chunky'
# }
# s = stub obj, 'me', (-> 'bacon') : stubs obj.me to return 'bacon'
# s.unstub()                       : obj.me toReturn 'chunky' again (obj.__unstub__() does the same thing)
#
# Mock
# stub that expects to be called
# h = {}
# m = mock h, 'bacon', -> 'chunky'
# h.bacon()                 : toReturn 'chunky'
# h.assertExpectationsMet() : asserts h.bacon was called 1x

class Expect
  constructor: (@obj, @method)->
    @origninal = @obj[@method]
    @reset()

    @obj[@method] = (args...)=>
      if @called then @called += 1 else @called = 1
      result = @origninal(args...)

      @calls.push {
        arguments: args
        returned: result
        context: @obj
      }

      result

  _teardown: =>
    @obj[@method] = @origninal

  reset: =>
    @called = false
    @calls = []
    @expectations = {
      calls: 0
      with: []
      toReturn: []
    }
    @

  with: (args...)=>
    @_with_called = true
    @expectations.calls += 1
    @expectations.with.push args
    @

  toReturn: (result)=>
    @expectations.calls += 1 unless @_with_called
    @_with_called = false
    @expectations.toReturn.push result
    @

  assertExpectationsMet: (expectations={})=>
    @expectations.calls = 1 if @expectations.calls == 0
    expectations = $.extend @expectations, expectations

    for expectation, val of expectations
      method = "assert#{expectation.slice(0,1).toUpperCase() + expectation.slice(1, expectation.length)}"
      if @[method]
        @[method](val)
      else
        console.log "Unknown expectation: #{expectation}"

    @_teardown()

  assertCalls: (number=1)=>
    equal @called, number, "#{@obj} expected(#{@method}) #{number}x, called #{@called}x"

  assertWith: (calls_args)=>
    for args, index in calls_args
      for arg, i in args
        continue if arg == undefined
        _msg_before = []
        _msg_before.push("...") for n in [0...i]
        _msg_before.push "" if _msg_before.length > 0
        _msg_before = _msg_before.join(', ')
        actual_arg = @calls[index].arguments[i]
        equal actual_arg, arg, "#{@obj} expected(#{@method}) x#{index+1} to be called with(#{_msg_before + arg}), got(#{_msg_before + actual_arg})"

  assertToReturn: (results)=>
    for result, index in results
      actual_result = @calls[index].returned
      equal actual_result, result, "#{@obj} expected(#{@method}) x#{index+1} to return(#{result}), returned(#{actual_result})"

_expect = expect
@expect = (obj, method)->
  # QUnit expect(n_assertions) method still works
  if typeof obj == 'number'
    _expect obj
  else
    new Expect obj, method


class Stub
  constructor: (@obj, @method, @fn)->
    @original = @obj[@method]
    @obj[@method] = @fn

    @obj.__unstub__ = @unstub

  unstub: =>
    @obj[@method] = @original

@stub = (obj, method, fn)->
  new Stub obj, method, fn

@mock = (obj, method, fn)->
  stub = @stub obj, method, fn
  stub.e = expect(obj, method)
  stub.assertExpectationsMet = stub.e.assertExpectationsMet
  stub

