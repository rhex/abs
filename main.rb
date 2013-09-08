$:.unshift(File.dirname(__FILE__))
require 'sinatra'
require 'sinatra/activerecord'
require 'models/book'
require 'rubberband'
# require 'config/environments'
# puts "rack env is #{ENV['RACK_ENV']}"
# ENV['RACK_ENV'] = 'test'
ENV['RACK_ENV'] = 'development'
configure :development do
  enable :logging
end

ActiveRecord::Base.establish_connection YAML::load(File.open('config/database.yml'))[ENV["RACK_ENV"]]

before do
  @all_books = Book.all
end

get '/' do
  puts YAML::load(File.open('config/database.yml'))[ENV["RACK_ENV"]]
  erb :main
end

get '/search' do
  @search_result = nil
  erb :search
end

post '/sql' do
  puts "#{params.inspect}"
  sql = "SELECT * FROM books WHERE body like '%#{params['sql_search']}%' or title like '%#{params['sql_search']}%'"
  @search_result = Book.find_by_sql sql
  erb :search
end

post '/sphinx' do
  puts "#{params.inspect}"
  @search_result = 'this is sphinx result'
  erb :search
end

post '/elastic' do
  puts "#{params.inspect}"
  client = ElasticSearch.new('http://127.0.0.1:9200', :index => "jdbc", :type => "jdbc")
  @search_result = client.search("#{params['elastic_search']}")
  erb :search
end
