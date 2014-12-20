# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("input.search").keydown (event) ->
    if event.keyCode is 13
      event.preventDefault()
      $(this).parent("form").submit()

  $("#featured").hide()  if $("li.beer").length
  return
