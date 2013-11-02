# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

teams = exports ? this

teams.remove_association = (link) ->
  $(link).prev("input[type=hidden]").val("true")
  $(link).closest(".association").hide()

teams.add_association = (association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")
  $(".association").last().after(content.replace(regexp, new_id))
