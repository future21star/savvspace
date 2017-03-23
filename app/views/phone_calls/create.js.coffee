$("#new_phone_call").replaceWith("<%= j(render partial: 'form') %>")
$("#new_call .modal-footer p").html("We are connecting you now.  If you don't receive a call in a minute, please double check your number.")
