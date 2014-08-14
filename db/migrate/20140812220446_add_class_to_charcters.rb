class AddClassToCharcters < ActiveRecord::Migration
  def change
    add_column :characters, :caste, :string
  end
end
