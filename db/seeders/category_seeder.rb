# frozen_string_literal: true

require_relative '../../app/models/category'

Category.destroy_all

categories = [
  {
    _id: 1,
    name: 'Science',
    description: 'Science is everything'
  },
  {
    _id: 2,
    name: 'Business',
    description: 'Affects the world'
  }
]

categories.each do |category|
  Category.create(category)
end
