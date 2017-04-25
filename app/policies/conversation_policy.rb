class ConversationPolicy < ApplicationPolicy
  def show?
    record.initiator == user.profile || record.recipient == user.profile
  end
end
