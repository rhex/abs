$:.unshift(File.dirname(__FILE__))
require 'sinatra'
require 'sinatra/activerecord'
require 'models/book'
# require 'config/environments'
puts "rack env is #{ENV['RACK_ENV']}"
# ENV['RACK_ENV'] = 'test'
ENV['RACK_ENV'] = 'development'
configure :development do
  enable :logging
end

ActiveRecord::Base.establish_connection YAML::load(File.open('config/database.yml'))[ENV["RACK_ENV"]]

get '/' do
  logger.debug YAML::load(File.open('config/database.yml'))[ENV["RACK_ENV"]]
  erb :main
end
