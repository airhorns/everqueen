QUnit.module('the spec helper');
test("should load js file", function() {
  equal(TestHelper.test, 'helper');
});
