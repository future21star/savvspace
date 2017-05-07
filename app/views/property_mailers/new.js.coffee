$('#modal').html("<%= j(render 'widgets/mailer_form', url: property_property_mailers_path(@property_id, referrer_id: @referrer_id)) %>")
$('#modal').modal('show')
