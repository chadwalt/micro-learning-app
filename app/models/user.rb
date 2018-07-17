# Manage user
class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :username
  validates_presence_of :password
  validates_presence_of :email

  field :first_name, type: String
  field :last_name, type: String
  field :username, type: String
  field :password_digest, type: String
  field :email, type: String
  field :role, type: String, default: 'user'
  field :image, type: String, default: 'blank_user.jpeg'
  field :interests, type: Array

  has_secure_password

  index({ email: 1 }, { unique: true, name: 'email_index' })
end
