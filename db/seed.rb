require '../models/book'
ENV['RACK_ENV'] = 'development'
ActiveRecord::Base.establish_connection YAML::load(File.open('../config/database.yml'))[ENV['RACK_ENV']]
Book.create(:title => 'book1', :body => 'body1', :price => 100)
