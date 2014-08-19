class AddUserIdToMultiple < ActiveRecord::Migration
  def change
    add_column :games, :user_id, :integer
    add_column :characters, :user_id, :integer
    add_column :resources, :user_id, :integer
    add_column :campaigns, :user_id, :integer
  end
end
