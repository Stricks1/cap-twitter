class Opinion < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  belongs_to :copied, class_name: 'User', foreign_key: 'copied_id', optional: true
end
