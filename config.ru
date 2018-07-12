require 'sinatra'

## Get all the controllers
Dir.glob('./app/{controllers}/*.rb').each { |file| require file }

map('/signup') { use SignupController }
map('/') { use SigninController }
run ApplicationController
