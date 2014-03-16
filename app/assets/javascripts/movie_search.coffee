$ ->
  $('.movie_title').autocomplete
    source: '/searches'
    search: ->
      load()
    response: ->
      finishLoad()
    select: (event, ui)->
      # item is selected from list
      load()
      self = this
      $.getJSON('/searches/' + ui.item.id)
        .done (data) ->
          # populate fields with movie data
          debugger
          finishLoad()
          $(self).val(data.title)
          $(self).nextAll('.overview').val(data.overview)
          $(self).nextAll('.poster_url').val(data.poster_url)

  load = ->
    $('#loading').show().animate({width: '80%'}, 5000)

  finishLoad = ->
    $('#loading').stop()
    .animate({width: '100%'}, 100)
    .fadeOut()
    .animate({width: '0%'}, 10)
