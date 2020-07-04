require 'rails_helper'

RSpec.describe User, type: :model do
  context 'model methods verification' do
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
      @user = User.find(1)
    end

    it 'check user followed opinions' do
      @user.followeds_opinions
      f = Opinion.order(created_at: :desc).find(2,1)
      expect(@user.followeds_opinions.first).to eq(f.first)
      expect(@user.followeds_opinions.last).to eq(f.last)
    end

    it 'who follow show unfollowed users on desc created order' do
      @user.who_follow
      f = User.order(created_at: :desc).find(2,3,4)
      expect(@user.who_follow.first).to eq(f[0])
      expect(@user.who_follow).to include(f[1])
      expect(@user.who_follow.last).to eq(f[2])
    end

    it 'unfollow user destroy the association between them' do
      expect(@user.follows).to include(User.find(5))
      @user.unfollow(5)
      expect(@user.follows).not_to include(User.find(5))
    end

    it 'retweet, copying opinion from another user opinion with copied id from user' do
      cop_op = Opinion.find(3)
      cop_op_text = cop_op.text
      @user.copy_opi(cop_op)
      expect(@user.opinions.last.text).to include(cop_op_text)
      expect(@user.opinions.last.copied_id).to eq(3)
    end
  end
end
