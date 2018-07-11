# Manage user
class User
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :username, type: String
  field :password, type: String
  field :email, type: String
  field :role, type: String, default: 'user'
  field :image, type: String, default: ''

  index({ email: 1 }, unique: true, name: 'email_index')
end
