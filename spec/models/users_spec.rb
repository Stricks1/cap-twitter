require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:user2) { build(:user) }
  let(:user3) { build(:user) }
  let(:user4) { build(:user) }
  let(:user5) { build(:user) }
  let(:f1) { build(:following, follower_id: user.id, followed_id: user5.id) }
  let(:f2) { build(:following, follower_id: user2.id, followed_id: user5.id) }
  let(:f3) { build(:following, follower_id: user3.id, followed_id: user5.id) }
  let(:f4) { build(:following, follower_id: user4.id, followed_id: user5.id) }
  let(:op1) { build(:opinion, user_id: user.id) }
  let(:op2) { build(:opinion, user_id: user5.id) }
  let(:op3) { build(:opinion, user_id: user3.id) }

  context 'Model methods verification' do
    before do
      user.save
      user2.save
      user3.save
      user4.save
      user5.save
      f1.save
      f2.save
      f3.save
      f4.save
      op1.save
      op2.save
      op3.save
    end

    it 'Check user followed opinions' do
      user.followeds_opinions
      f = Opinion.order(created_at: :desc).find(user2.id, user.id)
      expect(user.followeds_opinions.first).to eq(f.first)
      expect(user.followeds_opinions.last).to eq(f.last)
    end

    it 'Who follow show unfollowed users on desc created order' do
      user.who_follow
      f = User.order(created_at: :desc).find(user2.id, user3.id, user4.id)
      expect(user.who_follow.first).to eq(f[0])
      expect(user.who_follow).to include(f[1])
      expect(user.who_follow.last).to eq(f[2])
    end

    it 'Unfollow user destroy the association between them' do
      expect(user.follows).to include(user5)
      user.unfollow(5)
      expect(user.follows).not_to include(user5)
    end

    it 'Retweet, copying opinion from another user opinion with copied id from user' do
      cop_op = op3
      cop_op_text = cop_op.text
      user.copy_opi(cop_op)
      expect(user.opinions.last.text).to include(cop_op_text)
      expect(user.opinions.last.copied_id).to eq(op3.id)
    end

    it 'Scope ordered should show users order by created last' do
      users = User.ordered_users
      expect(users.first).to eq(user5)
      expect(users.last).to eq(user)
    end

    it 'Scope user and following should show self and following users' do
      ids = user.follows.select(user.id).ids
      ids << user.id
      users = User.user_and_following(ids)
      expect(users).to include(user5)
      expect(users).to include(user)
    end

    it 'Scope user who follow should show users not followed' do
      ids = user.follows.select(user.id).ids
      ids << user.id
      users = User.user_who_follow(ids)
      expect(users).to include(user3)
      expect(users).to include(user2)
      expect(users).not_to include(user)
      expect(users).not_to include(user5)
    end
  end
end
