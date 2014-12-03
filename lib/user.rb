require 'sinatra/activerecord'

class User < ActiveRecord::Base
  validates :email, :presence => true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, on: :create }
  validates :password, :presence => true
end