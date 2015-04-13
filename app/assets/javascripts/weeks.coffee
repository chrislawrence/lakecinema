$ ->
  collapseMovieFields()
  makeDaysSortable()

  $(document).on('nested:fieldAdded:movies', (event) ->
    collapseMovieFields()
    toggleAddDay(event.field)
    makeDaysSortable()
    $("a[rel*=leanModal]").leanModal()
  )

  $('.showing-fields').on('nested:fieldAdded', (event) ->
    day = $(event.link).data('predefined-day')
    field = event.field.find('.day-field')
    $(field).val(day)
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

  toggleWeekCategory()
  $("input[name='week[category]']").change ->
    toggleWeekCategory()

toggleWeekCategory = ->
  if $('#week_category_standard').is(':checked')
    $('#movie-week').show()
    $('#holiday-week').hide()
    $('#announcement-week').hide()
  else if $('#week_category_holiday').is(':checked')
    $('#movie-week').hide()
    $('#holiday-week').show()
    $('#announcement-week').hide()
  else
    $('#movie-week').hide()
    $('#holiday-week').hide()
    $('#announcement-week').show()

collapseMovieFields = ->
  $('.collapsed').hide()
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
