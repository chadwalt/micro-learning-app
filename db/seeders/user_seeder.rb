require_relative '../../app/models/user'

User.destroy_all

users = [
  {
    first_name: "timothy",
    last_name: "kyadondo",
    username: "chadwalt",
    password: "123",
    email: "timothy.kyadondo@gmail.com"
  },
  {
    first_name: "james",
    last_name: "kasule",
    username: "james",
    password: "12345",
    email: "james.kasule@gmail.com"
  },
]

users.each do |user|
  User.create(user)
end
