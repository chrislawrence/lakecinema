$ ->
  $('.movie_title_input').each( ->
    $(this).autocomplete
      source: '/searches'
      search: ->
        load(this)
      response: ->
        finishLoad(this)
      select: (event, ui)->
        # item is selected from list
        self = this
        load(this)
        $.getJSON('/searches/' + ui.item.id)
          .done (data) ->
            # populate fields with movie data
            finishLoad()
            $(self).val(data.title)
            $(self).nextAll('.overview').val(data.overview)
            $(self).nextAll('.poster_url').val(data.poster_url)

    load = (item)->
      debugger
      $(item).after("<div class='loading'></div>").nextAll('.loading').animate({width: '80%'}, 5000)

    finishLoad = (item) ->
      $(item).nextAll('.loading')
      .stop()
      .animate({width: '100%'}, 100)
      .fadeOut()
  )
