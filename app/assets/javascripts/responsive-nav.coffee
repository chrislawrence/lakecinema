$ ->
  $('.nav_toggle').click ->
    if $('.nav_list').is(':visible')
      $('.nav_list').slideUp()
    else
      $('.nav_list').slideDown()
