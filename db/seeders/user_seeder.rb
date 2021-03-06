# frozen_string_literal: true

require_relative '../../app/models/user'

User.destroy_all

users = [
  {
    _id: 1,
    first_name: 'timothy',
    last_name: 'kyadondo',
    username: 'chadwalt',
    password: '123',
    email: 'timothy.kyadondo@gmail.com',
    role: 'admin'
  },
  {
    _id: 2,
    first_name: 'james',
    last_name: 'kasule',
    username: 'james',
    password: '12345',
    email: 'james.kasule@gmail.com',
    role: 'user'
  }
]

users.each do |user|
  User.create(user)
end
