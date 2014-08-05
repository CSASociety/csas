class CreateAttachment < ActiveRecord::Migration
  def change
     create_table :attachments do |t|
      t.string :title
      t.integer :resource_id
      t.integer :attachable_id
      t.string :attachable_type
      t.timestamps
    end
  end
end
