$('#modal').html("<%= j(render 'form', property: @property, referrer_id: @referrer_id) %>")
$('#modal').modal('show')
