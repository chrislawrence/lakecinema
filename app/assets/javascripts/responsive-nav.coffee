$ ->
  $('.hamburger').click ->
    if $('.nav').is(':visible')
      $('.nav').slideUp()
    else
      $('.nav').slideDown()
