require 'rails_helper'

RSpec.describe 'Opinions_features', type: :feature, feature: true do
  context 'context' do
    before do
      User.destroy_all
      User.reset_pk_sequence
      Opinion.destroy_all
      Opinion.reset_pk_sequence
      Following.destroy_all
      Following.reset_pk_sequence
      User.create!([{
        username: "stricks",
        full_name: "Gabriel Silveira",
        photo: "https://avatars3.githubusercontent.com/u/60522356?s=400&u=c26966471d76a25d871027b43c0282504e04caca&v=4",
        cover_image: "https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2017/08/nature-design.jpg"
      },
      {
        username: "Harry",
        full_name: "Harry Potter",
        photo: "https://veja.abril.com.br/wp-content/uploads/2016/09/harrypotterrotter-1.jpg",
        cover_image: "https://i.pinimg.com/originals/c2/4b/e8/c24be8b914079df7aad2e3fb267d40f7.jpg"
      },
      {
        username: "Homer",
        full_name: "Homer Simpson",
        photo: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSCfQsBqjU65qA8FbFDJUWdukalbRS_0mt37A&usqp=CAU",
        cover_image: "https://i.pinimg.com/originals/69/46/cc/6946cc4f0029876320b10d2eae74a666.jpg"
      },
      {
        username: "Kenny",
        full_name: "Kenny McCormick",
        photo: "https://cdn.shopify.com/s/files/1/0843/2781/products/550746c4748b05ac3ca76e8d7be4db78_large.png",
        cover_image: "https://timelinecovers.pro/facebook-cover/download/video-game-south-park-the-stick-of-truth-facebook-cover.jpg"
      },
      {
        username: "rick",
        full_name: "Rick Sanchez",
        photo: "https://cdn-images.threadless.com/threadless-media/artist_shops/shops/SabanShirts/products/263319/shirt-1499232874-ef706e663ecb4f9d126822e0af3c6cdc.png?v=3&d=eyJvbmx5X21ldGEiOiBmYWxzZSwgImZvcmNlIjogZmFsc2UsICJvcHMiOiBbWyJ0cmltIiwgW2ZhbHNlLCBmYWxzZV0sIHt9XSwgWyJyZXNpemUiLCBbXSwgeyJ3aWR0aCI6IDk5Ni4wLCAiYWxsb3dfdXAiOiBmYWxzZSwgImhlaWdodCI6IDk5Ni4wfV0sIFsiY2FudmFzX2NlbnRlcmVkIiwgWzEyMDAsIDEyMDBdLCB7ImJhY2tncm91bmQiOiAiZmZmZmZmIn1dLCBbInRyaW0iLCBbXSwge31dLCBbInJlc2l6ZSIsIFs0OTgsIDQ5OF0sIHt9XSwgWyJjYW52YXNfY2VudGVyZWQiLCBbNjAwLCA2MDAsICJmZmZmZmYiXSwge31dLCBbImVuY29kZSIsIFsianBnIiwgODVdLCB7fV1dfQ==",
        cover_image: "https://wallpapercave.com/wp/wp2279644.jpg"
      }])
      Following.create!([{
        follower_id: 1,
        followed_id: 5,
      },
      {
        follower_id: 2,
        followed_id: 5,
      },
      {
        follower_id: 3,
        followed_id: 5,
      },
      {
        follower_id: 4,
        followed_id: 5,
      }])
      Opinion.create!([{
        text: 'First opinion about nothing',
        user_id: 1,
      },
      {
        text: 'Pickle riiiiiick',
        user_id: 5,
      },
      {
        text: 'Doh',
        user_id: 3,
      }])      
      visit 'http://localhost:3000/login'
      fill_in 'Username', with: 'stricks'
      find('.form-btn', match: :first).click
    end

    scenario 'log_in valid' do
      expect(page).to have_content('Logged in!')
    end
    
    scenario 'follow user, showing success on opinion page' do
      click_on('+', match: :first)
      expect(page).to have_content('Success following Kenny')
    end

    scenario 'click user, showing user profile page' do
      link = page.find("a .timeline-photo", match: :first).find(:xpath, '..')
      link.click
      expect(page).to have_content('All Rick Sanchez Opinions')
    end

    scenario 'unfollow user, showing success message' do
      link = page.find("a .timeline-photo", match: :first).find(:xpath, '..')
      link.click
      click_on('Unfollow')
      expect(page).to have_content('Unfollow rick')
    end

    scenario 'copy (retweet) user message' do
      link = page.find("a .timeline-photo", match: :first).find(:xpath, '..')
      link.click
      link = page.find("a .edit-opinion", match: :first).find(:xpath, '..')
      link.click
      expect(page).to have_content('Opinion copied from @rick')
    end

    scenario 'copy and edit (retweet) showing a copy was edited from user' do
      link = page.find("a .timeline-photo", match: :first).find(:xpath, '..')
      link.click
      link = page.find("a .edit-opinion", match: :first).find(:xpath, '..')
      link.click
      link = page.find("a .edit-opinion", match: :first).find(:xpath, '..')
      link.click
      fill_in 'opinion_text', with: 'This was edited'
      click_on('Edit Opinion')
      expect(page).to have_content('Edited opinion copied from @rick')
    end
  end
end
