$ ->
  collapseMovieFields()
  makeDaysSortable()
  toggleAddDay($(document))

  $(document).on('nested:fieldAdded:movies', (event) ->
    collapseMovieFields()
    toggleAddDay($(document))
    makeDaysSortable()
    setMovieOrder()
  )

  $(document).on('nested:fieldAdded:showings', (event) ->
    day = $(event.link).data('predefined-day')
    field = event.field.find('.day-field')
    $(field).val(day)
  )
  

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
  $('.movie-fields').focusin ->
    $(this).children('.collapsed').slideDown()
    $('.movie-fields').not(this).children('.collapsed').slideUp()

toggleAddDay = (field) ->
  field.find('.add-button').click ->
    $(this).slideToggle(80).next('.form-field').slideToggle(80)
  field.find('.day-link').click ->
    $(this).parent().slideToggle(80).prev('.add-button').slideToggle(80)

makeDaysSortable = ->
  $('.showing-fields').sortable({
    axis: 'y'
    update: ->
      $(this).children().each ->
        $(this).find('.position-field').val($(this).index())
  })

setMovieOrder = ->
  $('.movie-fields').each ->
    index = $('.movie-fields').index(this)
    $(this).children('.index-field').val(index)
