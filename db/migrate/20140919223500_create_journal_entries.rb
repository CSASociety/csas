class CreateJournalEntries < ActiveRecord::Migration
  def self.up
    create_table :journal_entries do |t|
      t.text :content
      t.string :date
      t.integer :player_character_id
      t.boolean :private, default: false
      t.timestamps
    end
  end

  def self.down
    drop_table :journal_entries
  end
end
