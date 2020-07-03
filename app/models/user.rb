class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :full_name, presence: true
  has_many :opinions, dependent: :destroy
  has_many :followers, class_name: 'Following', foreign_key: 'follower_id'
  has_many :followeds, class_name: 'Following', foreign_key: 'followed_id'
  has_many :follows, through: :followers, source: :followed
  has_many :followds, through: :followeds, source: :follower

  def followeds_opinions
    timeline_op = follows
    timeline_op << self
    Opinion.order(created_at: :desc).includes(:user).where({ user: [timeline_op]})
  end
end
