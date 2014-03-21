$ ->
  $('#message_nature').change ->
    selected = $('#message_nature option:selected').text()
    phone = $('#contact_phone')
    form = $('#contact_form_fields')
    if selected is 'Select One...'
      phone.hide()
      form.hide()
    else if selected is 'Booking/General Enquiry'
      phone.show()
      form.hide()
    else
      phone.hide()
      form.show()
