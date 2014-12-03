class AddColumnToDetails < ActiveRecord::Migration
  def change
  	add_column :details, :user_id, :integer
  end
end
