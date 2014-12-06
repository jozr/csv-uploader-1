class CreateTable < ActiveRecord::Migration
  def change
  	create_table :details do |t|
  	  t.string :purchaser_name
  	  t.string :description
  	  t.decimal :price, {:precision => 8, :scale => 2}
  	  t.integer :amount
  	  t.string :address
  	  t.string :merchant_name

  	  t.timestamps
  	end
  end
end