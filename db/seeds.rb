# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
    cover_image: ""
  },
  {
    username: "ricks",
    full_name: "Rick Sanchez",
    photo: "https://vignette.wikia.nocookie.net/rickandmorty/images/4/41/Pickle_rick_transparent_edgetrimmed.png/revision/latest?cb=20200324115455",
    cover_image: ""
  }])

p "Created #{User.count} users"

Following.create!([{
    follower_id: 1,
    followed_id: 2,
  }])

p "Created #{Following.count} follows"