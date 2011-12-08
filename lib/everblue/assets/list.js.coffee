window.Everblue = Everblue = {}

Everblue.Test = (element) ->
  self = this
  @element = $(element)
  @runLink = @element.find(".run")
  @runLink.click ->
    self.run()
    false

Everblue.Test::run = ->
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

Everblue.Test::done = (results) ->
  @runLink.removeClass "running"
  if results.failed > 0
    @runLink.addClass("fail").removeClass("pass").text "Fail"
  else
    @runLink.addClass("pass").removeClass("fail").text "Pass"
  @iframe.remove()

$ ->
  $("#tests li, #all").each ->
    new Everblue.Test(this)
