require 'sinatra'

## Get all the controllers
Dir.glob('./app/{controllers}/*.rb').each { |file| require file }

map('/signup') { use SignupController }
map('/') { use SigninController }
map('/profile') { use ProfileController }
map('/category') { use CategoryController }
run ApplicationController
