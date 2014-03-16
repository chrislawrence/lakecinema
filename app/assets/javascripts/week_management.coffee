$ ->
  $('#holiday_check_box').click ->
    if $('#holiday_check_box').is(':checked')
      $('#holiday_fields').show()
      $('#movie_fields').hide()
    else
      $('#holiday_fields').hide()
      $('#movie_fields').show()
