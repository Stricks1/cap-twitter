class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, format: { without: /[<>]/, message: "symbols '<' and '>' are invalid for username" }
  validates :full_name, presence: true
  has_many :opinions, dependent: :destroy
  has_many :followers, class_name: 'Following', foreign_key: 'follower_id', dependent: :destroy
  has_many :followeds, class_name: 'Following', foreign_key: 'followed_id', dependent: :destroy
  has_many :follows, through: :followers, source: :followed
  has_many :followds, through: :followeds, source: :follower

  def followeds_opinions
    ids = follows.select(:id).ids
    ids << id
    Opinion.ordered_opinion.include_user_copied.user_filter_Opinion(User.user_and_following(ids))
  end

  def who_follow
    ids = follows.select(:id).ids
    ids << id
    User.ordered_users.user_who_follow(ids)
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

  scope :ordered_users, -> { order(created_at: :desc) }
  scope :user_and_following, -> (ids) { where(id: ids) }
  scope :user_who_follow, -> (ids) { where.not(id: ids) }
end
