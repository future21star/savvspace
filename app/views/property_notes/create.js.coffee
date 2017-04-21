$("#notes_property_<%= @property_note.property_id %>").html("<%= j(render 'embedded_form') %>")
$("#notes_property_<%= @property_note.property_id %>").closest(".panel-body").removeClass("notes")
