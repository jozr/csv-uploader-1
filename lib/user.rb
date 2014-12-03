require 'sinatra/activerecord'

class User < ActiveRecord::Base

  validates :email, :presence => true
  validates :password, :presence => true
  has_many :details
end
