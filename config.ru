# frozen_string_literal: true

require 'sinatra'

## Get all the controllers
Dir.glob('./app/{controllers}/*.rb').each { |file| require file }

map('/signup') { use SignupController }
map('/') { use SigninController }
map('/profile') { use ProfileController }
map('/category') { use CategoryController }
map('/pages') { use PageController }
map('/user') { use UserController }

run ApplicationController
