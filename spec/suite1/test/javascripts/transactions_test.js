QUnit.module('transactions');

test("should add stuff in one test...", function() {
  $('#qunit-fixture').append('<h1 id="added">New Stuff</h1>');
  equal($('#qunit-fixture h1#added').length, 1);
});

test("... should have been removed before the next starts", function() {
  equal($('#qunit-fixture h1#added').length, 0);
});
