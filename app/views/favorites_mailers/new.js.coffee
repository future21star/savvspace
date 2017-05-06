$('#modal').html('<%= j(render 'form', referrer_id: @referrer_id) %>')
$('#modal').modal('show')
