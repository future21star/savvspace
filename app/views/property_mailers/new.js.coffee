$('#modal').html("<%= j(render 'widgets/mailer_form', item: :property_mailer, url: property_property_mailers_path(@property_id, referrer_id: @referrer_id)) %>")
$('#modal').modal('show')
