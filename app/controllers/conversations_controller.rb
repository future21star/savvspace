class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recipient = Profile.find(params[:profile_id])
    @conversation = Conversation.between(@recipient.id, current_profile).first ||
      Conversation.create(initiator: current_profile, recipient: @recipient)
  end

  def show
    @conversation = Conversation.find(params[:id])
    authorize @conversation

    # naiive read message indicator
    @conversation.messages.where(to: current_profile, read_at: nil).
      update_all(read_at: Time.current)
  end

  def index
    @conversations = Conversation.involving(current_profile.id).order(updated_at: :desc)
  end
end
