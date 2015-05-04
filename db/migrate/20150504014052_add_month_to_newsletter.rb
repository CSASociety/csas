class AddMonthToNewsletter < ActiveRecord::Migration
  def change
    add_column :newsletters, :month, :date
  end
end
