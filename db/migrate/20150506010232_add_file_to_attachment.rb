class AddFileToAttachment < ActiveRecord::Migration
  def change
    add_attachment :attachments, :file
    add_column :attachments, :entity_id, :integer
    add_column :attachments, :entity_type, :string
  end
end
