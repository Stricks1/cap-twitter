require 'rails_helper'

RSpec.describe User, type: :model do
  context 'model methods verification' do
    before do
      User.destroy_all
      User.reset_pk_sequence
      Following.destroy_all
      Following.reset_pk_sequence
      User.create!([
      {
        username: 'stricks',
        full_name: 'Gabriel Silveira',
        photo: 'https://avatars3.githubusercontent.com/u/60522356?s=400&u=c26966471d76a25d871027b43c0282504e04caca&v=4',
        cover_image: 'https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2017/08/nature-design.jpg'
      },
      {
        username: 'Harry',
        full_name: 'Harry Potter',
        photo: 'https://veja.abril.com.br/wp-content/uploads/2016/09/harrypotterrotter-1.jpg',
        cover_image: 'https://i.pinimg.com/originals/c2/4b/e8/c24be8b914079df7aad2e3fb267d40f7.jpg'
      }])
    end

    it 'create a new follow between users' do
      @user = User.find(1)
      @user2 = User.find(2)
      @following = Following.new
      @following.build_saving(@user2, @user)
      expect(@user.follows).to include(@user2)
      expect(@user2.followds).to include(@user)
    end
  end
end
