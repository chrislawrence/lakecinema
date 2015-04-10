autoComplete = ->
    $('.movie-title').each( ->
      $(this).autocomplete
        source: '/searches'
        search: ->
          load(this)
        response: (event, ui)->
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
              fields = $(self).parent().parent()
              fields.children('.overview').children('textarea').val(data.overview)
              fields.children('.director').children('input').val(data.director)
              fields.children('.cast').children('input').val(data.cast)
              debugger
              fields.find('.tmdb-id').val(data.id)
              fields.find('.poster-field').children('img').attr('src', data.poster_thumb)
              fields.find('.poster-url').val(data.poster_url)

      load = (item)->
        $(item).after("<div class='loading'></div>").nextAll('.loading').animate({width: '80%'}, 5000)

      finishLoad = (item) ->
        $(item).nextAll('.loading')
        .stop()
        .animate({width: '100%'}, 100)
        .fadeOut()
    )

$ ->
  autoComplete()
$(document).on('nested:fieldAdded', ->
  autoComplete()
)
