# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

questions = exports ? this

setSingleAnswer = (val) ->
  $("#answer").attr("value", JSON.stringify(val))

setListAnswers = (val) ->
  current = $("#answer").attr("value")
  if current?
    current = JSON.parse(current)
  else
    current = []
  current.push(val)
  $("#answer").attr("value", JSON.stringify(current))

setHashAnswer = (key, val) ->
  current = $("#answer").attr("value")
  if current?
    current = JSON.parse(current)
  else
    current = {}
  current[key] = val
  $("#answer").attr("value", JSON.stringify(current))

radioClick = (e) ->
  $(".radio").each (_, elem) ->
    $(elem).css("background-color", "")
  $(this).css("background-color", "white")
  setSingleAnswer($(this).data("answer"))

droppableDrop = (e, ui) ->
  draggable = $(ui.draggable.context).data("answer")
  droppable = $(this).data("answer")
  setHashAnswer(draggable, droppable)
  $(ui.draggable).draggable('disable')

checkClick = (e) ->
  $(this).toggleClass("checked")
  setListAnswers($(this).data("answer"))

multiRadioClick = (e) ->
  name = this.attributes.name.value
  $("img[name=#{name}]").each (_, elem) ->
    $(elem).removeClass "selected"
  $(this).toggleClass "selected"
  answer = $(this).data("answer").split(":")
  setHashAnswer(answer[0], answer[1])

poseidonClick = (e) ->
  $(".poseidon-book").css("display", "block")

pauseClick = (e) ->
  video = document.getElementById("oxigenio")
  if video.paused then video.play() else video.pause()
  $("#pause").toggleClass("pause")
  $(".track").toggle()

configure = ->
  $(".questions .drag").draggable()
  $(".questions .drop").droppable drop: droppableDrop
  $(".questions .radio").click radioClick
  $(".questions .check").click checkClick
  $(".questions .multi-radio").click multiRadioClick
  $(".questions .poseidon").click poseidonClick
  $(".questions #pause").click pauseClick
  $(".questions #answer").attr("value", null)

$(document).on "page:load", () ->
  configure()

$(document).ready () ->
  configure()
