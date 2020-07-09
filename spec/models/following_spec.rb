require 'rails_helper'

RSpec.describe Following, type: :model do
  let(:user) { build(:user) }
  let(:user2) { build(:user) }

  context 'Model methods verification' do
    it 'Create a new follow between users' do
      @following = Following.new
      @following.build_saving(user2, user)
      expect(user.follows).to include(user2)
      expect(user2.followds).to include(user)
    end

    it 'Fails to create a follow missing one user' do
      @following = Following.new
      @following.build_saving(user2, nil)
      expect(@following.errors.full_messages).to include("Follower can't be blank")
      @following.build_saving(nil, user)
      expect(@following.errors.full_messages).to include("Followed can't be blank")
    end
  end
end
