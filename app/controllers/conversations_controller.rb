class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipient = Profile.find(params[:profile_id])
    @conversation = Conversation.between(@recipient.id, current_user.profile).first ||
      Conversation.create(initiator: current_user.profile, recipient: @recipient)
  end
end
