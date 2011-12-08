window.Everqueen = Everqueen = {}

Everqueen.Test = (element) ->
  self = this
  @element = $(element)
  @runLink = @element.find(".run")
  @runLink.click ->
    self.run()
    false

Everqueen.Test::run = ->
  self = this
  @iframe = $("<iframe></iframe>").attr("src", @runLink.attr("href")).appendTo(@element)
  @iframe.css
    position: "absolute"
    left: "-20000px"

  @runLink.addClass("running").text "Running…"
  $(@iframe).load ->
    context = self.iframe.get(0).contentWindow
    innerQUnit = context.QUnit
    innerQUnit.done (results) ->
      self.done results

Everqueen.Test::done = (results) ->
  @runLink.removeClass "running"
  if results.failed > 0
    @runLink.addClass("fail").removeClass("pass").text "Fail"
  else
    @runLink.addClass("pass").removeClass("fail").text "Pass"
  @iframe.remove()

$ ->
  $("#tests li, #all").each ->
    new Everqueen.Test(this)
