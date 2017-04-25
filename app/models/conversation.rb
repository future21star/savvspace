class Conversation < ActiveRecord::Base
  belongs_to :initiator, class_name: "Profile"
  belongs_to :recipient, class_name: "Profile"

  validates :initiator, :recipient, presence: true

  has_many :messages, dependent: :destroy

  scope :between, -> (initiator_id,recipient_id) do
    where("(conversations.initiator_id = ? AND conversations.recipient_id =?) OR (conversations.initiator_id = ? AND conversations.recipient_id =?)", initiator_id,recipient_id, recipient_id, initiator_id)
  end

  scope :involving, -> (participant_id) do
    where("conversations.initiator_id = ? OR conversations.recipient_id = ?", participant_id, participant_id)
  end
end
