$('[data-target=#ajax-modal]').on 'click', (e) ->
  e.preventDefault()
  e.stopPropagation()
  $('body').modalmanager('loading')
  $.rails.handleRemote($(this))

$(document).on 'click', '[data-dismiss=modal], .modal-scrollable', ->
  $('.modal-body-content').empty()

$(document).on 'click', '#ajax-modal', (e) ->
  e.stopPropagation()
