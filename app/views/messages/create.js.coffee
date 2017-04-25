<% if @message.follow_up? %>
$("#<%= dom_id(@message.previous) %>").after("<%= j(render partial: 'message_body', locals: {message: @message}) %>")
$("#<%= dom_id(@message.previous, :footer) %>").replaceWith("<%= j(render partial: 'message_footer', locals: {message: @message}) %>")
<% else %>
$("#<%= dom_id(@message.conversation) %>").append("<%= j(render @message) %>")
<% end %>
$("#new_message #message_body").val("")
