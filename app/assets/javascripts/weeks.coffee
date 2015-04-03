$ ->
  collapseMovieFields()
  toggleAddDay($(this))
  makeDaysSortable()

  $(document).on('nested:fieldAdded:movies', (event) ->
    collapseMovieFields()
    toggleAddDay(event.field)
    makeDaysSortable()
  )

  $('.showing-fields').on('nested:fieldAdded', (event) ->
    day = $(event.link).data('predefined-day')
    field = event.field.find('.day-field')
    label = event.field.find('.day-label')
    $(field).val(day)
    $(label).text(day)
  )
  
  $("a[rel*=leanModal]").leanModal()

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

collapseMovieFields = ->
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

toggleAddDay = (field) ->
  field.find('.add-button').click ->
    console.log('add clicked')
    $(this).slideToggle(80).next('.form-field').slideToggle(80)
  field.find('.day-link').click ->
    console.log('link clicked')
    $(this).parent().slideToggle(80).prev('.add-button').slideToggle(80)

makeDaysSortable = ->
  $('.showing-fields').sortable({
    axis: 'y'
    update: ->
      $(this).children().each ->
        $(this).find('.position-field').val($(this).index())
  })
