$('#modal').html("<%= j(render 'widgets/mailer_form', url: favorites_mailers_path(referrer_id: @referrer_id, item_type: @item_type)) %>")
$('#modal').modal('show')
