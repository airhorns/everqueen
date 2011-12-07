if(!this.JSON){this.JSON={};}

var Everblue = {};

Everblue.dots = ""

Everblue.ReflectiveReporter = function() {
  this.reportRunnerStarting = function(runner) {
    Everblue.results = [];
  };
  this.reportTestResults = function(test) {
    var results = test.results();
    var item = results.getItems()[0] || {};
    Everblue.results.push({
      name: test.getFullName(),
      passed: results.failedCount === 0,
      message: item.message,
      trace: item.trace
    });
    Everblue.dots += (results.failedCount === 0) ? "." : "F";
  };
  this.reportRunnerResults = function(runner) {
    Everblue.done = true;
    if(Everblue.onDone) { Everblue.onDone() }
  };
};

Everblue.templates = {};

Everblue.getResults = function() {
  return JSON.stringify(Everblue.results);
};
