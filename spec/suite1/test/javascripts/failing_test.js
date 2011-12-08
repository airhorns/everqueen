QUnit.module('failing spec');

test("should pass", function() {
  equal('foo', 'foo');
});

test("should fail", function() {
  equal('bar', 'noooooo');
});
