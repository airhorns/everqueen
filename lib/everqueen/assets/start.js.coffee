run = -> QUnit.start()

if window.addEventListener
  window.addEventListener "load", run, false
else
  window.attachEvent "onload", run
