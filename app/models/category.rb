# Handle category database operations
class Category
  include Mongoid::Document

  validates_presence_of :name

  field :name, type: String
  field :description, type: String

  index({ name: 1 }, { unique: true, name: 'name_index' })
end
