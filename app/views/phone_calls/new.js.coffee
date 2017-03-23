$("#new_call .modal-body").html("<%= j(render partial: 'form') %>")
$("#new_call .modal-footer p").html("We will call you at the number of above and connect you to <br/> <%= @phone_call.profile.name %>")
