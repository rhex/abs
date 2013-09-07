require 'active_record'
class Book < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
  validates :price, presence: true
end
