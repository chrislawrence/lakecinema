$ ->
  $('.btn-group .btn').click ->
    toggleButtonGroup($(this))
    
    if $(this).hasClass('btn-holiday')
      $(document).find('#holiday-week').show()
      $(document).find('#movie-week').hide()
    else
      $(document).find('#holiday-week').hide()
      $(document).find('#movie-week').show()

toggleButtonGroup = (btn) ->
  group = btn.parent()
  group.find('.btn').removeClass('active')
  console.log('add class')
  btn.addClass('active')


  
