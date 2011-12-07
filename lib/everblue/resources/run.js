if(!this.JSON){this.JSON={};}

var Everblue = {};

Everblue.dots = ""

Everblue.ReflectiveReporter = function() {
  this.reportRunnerStarting = function(runner) {
    Everblue.results = [];
  };
  this.reportSpecResults = function(spec) {
    var results = spec.results();
    var item = results.getItems()[0] || {};
    Everblue.results.push({
      name: spec.getFullName(),
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

beforeEach(function() {
  document.getElementById('test').innerHTML = "";
});

var template = function(name) {
  beforeEach(function() {
    document.getElementById('test').innerHTML = Everblue.templates[name]
  });
};

var require = function(file) {
  document.write('<script type="text/javascript" src="' + file + '"></script>');
};

var stylesheet = function(file) {
  document.write('<link rel="stylesheet" type="text/css" href="' + file + '"/>');
};
