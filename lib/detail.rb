require 'pg'
require 'sinatra/activerecord'

class Detail < ActiveRecord::Base

  DB = PG.connect({:dbname => 'deal_a_day'})

  validates :purchaser_name, :presence => true
  validates :description, :presence => true
  validates :price, :presence => true
  validates :amount, :presence => true
  validates :address, :presence => true
  validates :merchant_name, :presence => true
  validates :user_id, :presence => true
  belongs_to :user

  def self.upload(file)
    File.open('uploads/' + file[:filename], "w") do |f|
      f.write(file[:tempfile].read)
    end
    file_name = File.absolute_path('uploads/' + file[:filename]) 
    DB.exec("COPY details(purchaser_name, description, price, amount, address, merchant_name) FROM '#{file_name}' WITH CSV HEADER DELIMITER AS ',';")
    DB.exec("UPDATE details SET created_at = NOW() WHERE created_at IS NULL;")
  end

  def self.latest_upload_revenue
    total = 0
    latest_upload = Detail.order('created_at').last
    Detail.all.each do |d|
      if d.created_at == latest_upload.created_at
        total += d.price * d.amount
      end
    end
    total
  end
end