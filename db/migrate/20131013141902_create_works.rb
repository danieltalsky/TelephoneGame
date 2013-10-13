class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.text :title
      t.integer :parent_id
      t.integer :artist_id
      t.text :medium
      t.belongs_to :artist
      
      t.timestamps
    end
  end
end
