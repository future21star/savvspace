class Message < ActiveRecord::Base
  belongs_to :conversation, touch: true
  belongs_to :from, class_name: "Profile"
  belongs_to :to, class_name: "Profile"

  validates :conversation, :from, presence: true

  def previous
    conversation.messages.order(created_at: :desc).where(['created_at < ?', created_at]).first
  end

  def next
    conversation.messages.order(created_at: :asc).where(['created_at > ?', created_at]).first
  end

  def follow_up?
    previous && previous.from == from
  end
end
