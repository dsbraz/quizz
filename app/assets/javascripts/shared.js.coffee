shared = exports ? this

poseidonBookClick = (e) ->
  $(".poseidon-book").css("display", "none")

configure = ->
  $(".poseidon-book").click poseidonBookClick

$(document).on "page:load", () ->
  configure()

$(document).ready () ->
  configure()
