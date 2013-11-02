# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

players = exports ? this

detalheClick = (e) ->
  $("#poseidonIntro").show()
  document.getElementById("poseidonIntro").play()

poseidonIntroEnded = (e) ->
  $("#poseidonIntro").hide()
  document.getElementById("poseidonIntro").pause()
  $("#avatarIntro").show()
  document.getElementById("avatarIntro").play()

avatarIntroEnded = (e) ->
  $("#avatarIntro").hide()
  document.getElementById("avatarIntro").pause()
  $("#form").submit()

configure = ->
  $(".players #detalhe").click detalheClick
  $(".players #poseidonIntro").on "ended", poseidonIntroEnded
  $(".players #avatarIntro").on "ended", avatarIntroEnded

$(document).on "page:load", () ->
  configure()

$(document).ready () ->
  configure()
