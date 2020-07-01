class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :full_name, presence: true
  has_many :opinions, dependent: :destroy
  has_many :followers, class_name: 'Following', foreign_key: 'follower_id'
  has_many :followeds, class_name: 'Following', foreign_key: 'followed_id'
end
