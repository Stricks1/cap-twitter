FactoryBot.define do
  factory :user do
    username { FFaker::Lorem.unique.word }
    full_name { FFaker::Name.name }
    photo { %w[https://avatars3.githubusercontent.com/u/60522356?s=400&u=c26966471d76a25d871027b43c0282504e04caca&v=4 https://veja.abril.com.br/wp-content/uploads/2016/09/harrypotterrotter-1.jpg].sample }
    cover_image { %w[https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2017/08/nature-design.jpg https://i.pinimg.com/originals/c2/4b/e8/c24be8b914079df7aad2e3fb267d40f7.jpg].sample }
  end

  factory :following do
    follower_id { FFaker::Random.rand(1..6) }
    followed_id { FFaker::Random.rand(1..6) }
  end

  factory :opinion do
    text { FFaker::Lorem.sentence }
    user_id { FFaker::Random.rand(1..6) }
  end
end
