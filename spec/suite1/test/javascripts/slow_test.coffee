QUnit.module 'slow specs'

asyncTest "should wait for results to show", ->
  equal('foo', 'foo')
  setTimeout ->
    equal('bar', 'baz')
    QUnit.start()
  , 1000
