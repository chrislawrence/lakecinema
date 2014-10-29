$ ->
  toggleFields = ->
    if $('#week_category_standard').is(':checked')
      $('#movie_fields').show()
      $('#holiday_fields').hide()
      $('#announcement_fields').hide()
    else if $('#week_category_holiday').is(':checked')
      $('#movie_fields').hide()
      $('#holiday_fields').show()
      $('#announcement_fields').hide()
    else if $('#week_category_announcement').is(':checked')
      $('#movie_fields').hide()
      $('#holiday_fields').hide()
      $('#announcement_fields').show()

  $('#week_category_standard, #week_category_holiday, #week_category_announcement').change ->
    toggleFields()

  $(document).ready ->
    toggleFields()

  $('.toggle-overview').each ->
    $(this).click (e)->
      e.preventDefault()
      link = $(this)
      $(this).parent().nextAll('.movie-overview').slideToggle(400, 'easeInQuint', ->
        link.text(if link.text() is 'More info...' then 'Less..' else 'More info...')
      )
