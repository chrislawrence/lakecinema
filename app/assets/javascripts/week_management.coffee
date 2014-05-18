$ ->
  $('#holiday_check_box').click ->
    if $('#holiday_check_box').is(':checked')
      $('#holiday_fields').show()
      $('#movie_fields').hide()
    else
      $('#holiday_fields').hide()
      $('#movie_fields').show()
  $('.toggle-overview').each ->
    $(this).click (e)->
      e.preventDefault()
      link = $(this)
      $(this).parent().nextAll('.movie-overview').slideToggle(400, 'easeInQuint', ->
        link.text(if link.text() is 'More info...' then 'Less..' else 'More info...')
      )
