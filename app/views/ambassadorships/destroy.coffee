jQuery ->
        ele = $("#ambassadorship_embedded_form").replaceWith("<%= j(render partial: 'embedded_form') %>")
