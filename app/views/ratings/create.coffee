jQuery ->
        $("#<%= dom_id(@rating.rateable) %>.rateable").replaceWith("<%= j(render partial: 'common/rating', locals: {rateable: @rating.rateable}) %>")
        refreshRatings("#<%= dom_id(@rating.rateable) %>.rateable select")
