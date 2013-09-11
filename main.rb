$:.unshift(File.dirname(__FILE__))
require 'sinatra'
require 'sinatra/activerecord'
require 'models/book'
require 'rubberband'
require 'stretcher'
require 'sphinx'
require 'rsolr'
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
  puts @search_result
  puts @search_result.class
  erb :search
end

post '/sphinx' do
  puts "#{params.inspect}"
  sphinx = Sphinx::Client.new
  # sphinx.set_server 'localhost', 9312
  # sphinx.set_match_mode Sphinx::SPH_MATCH_ALL
  # sphinx.set_limits 0, 10**10
  query = "*#{params['sphinx_search']}*"
  result = sphinx.query(query)
  r = []
  result['matches'].each { |m| r << m['id'] }
  @search_result =
    if r.empty?
      []
    else
     Book.find(r) 
    end
  erb :search
end

post '/elastic' do
  puts "#{params.inspect}"
  client = ElasticSearch.new('http://127.0.0.1:9200', :index => "jdbc", :type => "jdbc")
  @search_result = client.search("#{params['elastic_search']}")
  # server = Stretcher::Server.new('http://localhost:9200')
  # res = server.index(:jdbc).search(size: 12, query: {match_all: {}})
  # puts res
  erb :search
end


post '/solr' do
  puts "#{params.inspect}"
  solr = RSolr.connect :url => 'http://localhost:8983/solr/collection1/'
  # TODO: convert hash to object
  result = solr.get 'select', :params => {:q => "#{params['solr_search']}"}
  ids = result['response']['docs'].map { |item| item['id'] }
  @search_result = Book.find(ids) 
  erb :search
end
