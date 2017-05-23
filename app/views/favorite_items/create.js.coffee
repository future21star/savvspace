$(".favorite-link#<%= dom_id(@favorite_item.favorite) %>").replaceWith("<%= j(render partial: 'link', locals: {item: @favorite_item.favorite, referrer_id: @favorite_item.referrer_profile_id}) %>")
