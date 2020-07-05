class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, format: { without: /[<>]/, message: "symbols '<' and '>' are invalid for username" }
  validates :full_name, presence: true
  has_many :opinions, dependent: :destroy
  has_many :followers, class_name: 'Following', foreign_key: 'follower_id'
  has_many :followeds, class_name: 'Following', foreign_key: 'followed_id'
  has_many :follows, through: :followers, source: :followed
  has_many :followds, through: :followeds, source: :follower

  def followeds_opinions
    Opinion.order(created_at: :desc).includes(:user, :copied).where({ user: [User.find(id, follows.select(:id).ids)] })
  end

  def who_follow
    ids = follows.select(:id).ids
    ids << id
    User.order(created_at: :desc).where.not({ id: [ids] })
  end

  def unfollow(user)
    follows.destroy(user)
  end

  def copy_opi(opi)
    copy_opinion = if opi.copied_id.nil? || opi.created_at != opi.updated_at
                     opinions.build(text: opi.text, copied_id: opi.user_id)
                   else
                     opinions.build(text: opi.text, copied_id: opi.copied_id)
                   end
    copy_opinion.save
  end
end
