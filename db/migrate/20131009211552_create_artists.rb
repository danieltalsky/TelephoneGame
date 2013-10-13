class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.text :name
      t.text :contact
      t.text :bio
      t.text :url
      t.text :location
      t.has_many :works

      t.timestamps
    end
  end
end
