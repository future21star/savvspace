$(".authorization-link#<%= dom_id(@user) %>").replaceWith("<%= j(render partial: 'link', locals: {user: @user}) %>")
