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
      movie = $.getJSON('/search_suggestions/' + ui.item.id)
        .done (data) ->
          # populate fields with movie data
          finishLoad()
          $('#title').val(data.title)
          $('#description').val(data.overview)
          $('#poster').val(data.poster_url)

  load = ->
    $('#loading').show().animate({width: '80%'}, 5000)
  finishLoad = ->
    $('#loading').stop()
    .animate({width: '100%'}, 100)
    .fadeOut()
    .animate({width: '0%'}, 10)
