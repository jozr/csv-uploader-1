class RemoveColumn < ActiveRecord::Migration
  def change
  	remove_column :details, :updated_at
  end
end
