# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

tracks = exports ? this

poseidonClick = (e) ->
  $(".poseidon-book").css("display", "block")

summaryClick = (e) ->
  location.href = $(".summary").data("path")

configure = ->
  $(".tracks .poseidon").click poseidonClick
  $(".tracks .summary").click summaryClick

$(document).on "page:load", () ->
  configure()

$(document).ready () ->
  configure()
