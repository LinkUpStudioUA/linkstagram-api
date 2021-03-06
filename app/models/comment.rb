class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :commenter, class_name: 'Account'

  validates :message, presence: true

  scope :ordered, -> { order(created_at: :asc) }
  scope :with_commenter, -> { includes([:commenter]) }
end
