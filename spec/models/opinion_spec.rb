require 'rails_helper'

RSpec.describe Opinion, type: :model do
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

  context 'model methods verification' do
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

    it 'Do not save opinion with empty text' do
      @opinion = Opinion.new
      @opinion.text = nil
      @opinion.validate
      expect(@opinion.errors.full_messages).to include("Text can't be blank")
    end

    it 'Scope should return ordered opinions by recent' do
      ops = Opinion.ordered_opinion
      expect(ops.first).to eq(op3)
      expect(ops.last).to eq(op1)
    end

    it 'Scope should return including user records for users/copied' do
      ops = Opinion.ordered_opinion.include_user_copied
      expect(ops.first.user).to eq(op3.user)
      expect(ops.last.user).to eq(op1.user)
    end

    it 'Scope should return just user opinions' do
      ops = Opinion.user_filter_Opinion(user.id)
      expect(ops).to include(op1)
      expect(ops).not_to eq(op2)
      expect(ops).not_to eq(op3)
    end
  end
end
