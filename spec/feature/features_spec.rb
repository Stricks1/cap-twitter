require 'rails_helper'

RSpec.describe 'Opinions_features', type: :feature, feature: true do
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

  context 'logged in user' do
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
      visit 'http://localhost:3000/login'
      fill_in 'Username', with: user.username
      find('.form-btn', match: :first).click
    end

    it 'log_in valid' do
      expect(page).to have_content('Logged in!')
    end

    scenario 'follow user, showing success on opinion page' do
      click_on('+', match: :first)
      expect(page).to have_content("Success following #{user4.username}")
    end

    scenario 'click user, showing user profile page' do
      link = page.find('a .timeline-photo', match: :first).find(:xpath, '..')
      link.click
      expect(page).to have_content("All #{user5.full_name} Opinions")
    end

    scenario 'unfollow user, showing success message' do
      link = page.find('a .timeline-photo', match: :first).find(:xpath, '..')
      link.click
      click_on('Unfollow')
      expect(page).to have_content("Unfollow #{user5.username}")
    end

    scenario 'create opinion message' do
      fill_in 'opinion_text', with: 'This new opinion'
      click_on('Send Opinion')
      expect(page).to have_content('This new opinion')
    end

    scenario 'copy (retweet) user message' do
      link = page.find('a .timeline-photo', match: :first).find(:xpath, '..')
      link.click
      link = page.find('a .edit-opinion', match: :first).find(:xpath, '..')
      link.click
      expect(page).to have_content("Opinion copied from @#{user5.username}")
    end

    scenario 'copy and edit (retweet) showing a copy was edited from user' do
      link = page.find('a .timeline-photo', match: :first).find(:xpath, '..')
      link.click
      link = page.find('a .edit-opinion', match: :first).find(:xpath, '..')
      link.click
      link = page.find('a .edit-opinion', match: :first).find(:xpath, '..')
      link.click
      fill_in 'opinion_text', with: 'This was edited'
      click_on('Edit Opinion')
      expect(page).to have_content('This was edited')
      expect(page).to have_content("Edited opinion copied from @#{user5.username}")
    end
  end
end
