require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:user2) { build(:user) }

  context 'model methods verification' do
    it 'create a new follow between users' do
      @following = Following.new
      @following.build_saving(user2, user)
      expect(user.follows).to include(user2)
      expect(user2.followds).to include(user)
    end
  end
end
