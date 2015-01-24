class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.timestamps
    end
    add_attachment :newsletters, :file
  end
end
