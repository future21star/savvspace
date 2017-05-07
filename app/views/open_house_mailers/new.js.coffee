$('#modal').html("<%= j(render 'widgets/mailer_form', item: :open_house_mailer, url: open_house_open_house_mailers_path(@open_house_id, referrer_id: @referrer_id)) %>")
$('#modal').modal('show')
