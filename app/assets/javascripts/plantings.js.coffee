# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.add-datepicker').datepicker('format' : 'yyyy-mm-dd')

  $('#planting-quick-form').on("ajax:success", (e, data, status, xhr) ->
    $('#crop').empty()
    $('#planting-quick-form').hide()
    location.reload()
  ).on "ajax:error", (e, xhr, status, error) ->
    $('#planting-quick-form').append "<p>ERROR</p>"