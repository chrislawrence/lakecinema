$ ->
  $('.date-field').datepicker({
    prevText: "<"
    nextText: ">"
    minDate: 0
    dateFormat: 'dd-mm-yy'
    onSelect: (d) ->
      parts = d.split('-')
      d = new Date(
        parts[2],
        parts[1] - 1,
        parts[0]
      )
      d.setDate(d.getDate() + 2)
      $(this).parent().next('.form-field').children('.date-field').datepicker("setDate", d)
  })


  collapseFields = ->
    timeoutID = []

    checkDelay = (fields) ->
      timeoutID[fields.attr('id')] = setTimeout( ->
        # Do this if moving outside of the field group
        unless $(fields).is(':hover')
          fields.children('.collapsed').slideUp()
      , 1 )

    $('.movie-fields').each( ->
      $(this).focusin ->
        $(this).children('.collapsed').slideDown()
        # cancel the action if still within form group
        if timeoutID[$(this).attr('id')]
          clearTimeout(timeoutID[$(this).attr('id')])
          timeoutID[$(this).attr('id')] = null
    )

    $('.movie-fields').each( ->
      $(this).focusout ->
        # start action when moving out of a field
        checkDelay($(this))
    )

  # Start this when document ready and when nested field added
  collapseFields()
  $(document).on('nested:fieldAdded', ->
    collapseFields()
  )

    
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

