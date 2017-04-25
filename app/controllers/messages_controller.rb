class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
#    authorize @conversation
    @message = @conversation.messages.create!(message_params.merge(from: current_user.profile))
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
