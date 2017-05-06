$('#modal').html("<%= j(render 'widgets/mailer_form', item: :favorites_mailer, url: favorites_mailers_path(referrer_id: @referrer_id)) %>")
$('#modal').modal('show')
