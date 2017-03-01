class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string "name", :limit => 100, :null => false
      t.string "description", :limit => 250, :null => false
      t.boolean "visible", :default => false
      t.timestamps null: false
    end
  end
end
