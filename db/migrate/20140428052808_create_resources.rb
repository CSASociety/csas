class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.timestamps
    end
    add_attachment :resources, :file
  end

  def self.down
    drop_table :resources
  end
end
