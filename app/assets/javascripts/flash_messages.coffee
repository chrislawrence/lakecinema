$ ->
  $('.flash').each ->
    $(this).slideDown(300).delay(1500).slideUp(300, ->
      $(this).remove()
      )

