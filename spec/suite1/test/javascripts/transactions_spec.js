QUnit.module('transactions');

test("should add stuff in one test...", function() {
  $('#test').append('<h1 id="added">New Stuff</h1>');
  equal($('#test h1#added').length, 1);
});

test("... should have been removed before the next starts", function() {
  equal($('#test h1#added').length, 0);
});
