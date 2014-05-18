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
            finishLoad(self)
            $(self).val(data.title)
            fields = $(self).parent().nextAll('.movie_details')
            fields.children('.overview').val(data.overview)
            fields.children('.poster_url').val(data.poster_url)
            fields.children('.tmdb_id').val(data.id)
            fields.nextAll('.poster_preview').children('img').attr('src', data.poster_thumb)

    load = (item)->
      $(item).after("<div class='loading'></div>").nextAll('.loading').animate({width: '80%'}, 5000)

    finishLoad = (item) ->
      $(item).nextAll('.loading')
      .stop()
      .animate({width: '100%'}, 100)
      .fadeOut()
  )
