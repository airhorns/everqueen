//= require implementation

QUnit.module('with no tokens');

test("should return an empty string if an empty string is given", function() {
  expect(foo).toEqual('foo');
});

test("should return a string unchanged", function() {
  expect(foo).toEqual('foo');
});

QUnit.module('with one token');
test("should replace the token with an empty string if no value is passed in", function() {
  expect(foo).toEqual('foo');
})

test("should replace the token with a given value", function() {
})

test("should not replace partial token matches", function() {
})

test("should work when calling replace twice on the same string template", function() {
})

QUnit.module('with two tokens (OMG!?)');
test("should replace all tokens with their values", function() {
})

test("should not do anything about tokens not present in the string template", function() {
})

test("should replace tokens without value with the empty string", function() {
})
