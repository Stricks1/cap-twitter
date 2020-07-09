class Opinion < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  belongs_to :copied, class_name: 'User', foreign_key: 'copied_id', optional: true

  scope :ordered_opinion, -> { order(created_at: :desc) }
  scope :include_user_copied, -> { includes(:user, :copied) }
  scope :user_filter_Opinion, ->(user) { where(user: user) }
end
