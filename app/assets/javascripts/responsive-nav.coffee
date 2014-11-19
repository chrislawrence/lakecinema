$ ->
  $('.nav-toggle').click ->
    if $('.nav-list').is(':visible')
      $('.nav-list').slideUp()
    else
      $('.nav-list').slideDown()
