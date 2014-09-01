class CreateCuratedTours < ActiveRecord::Migration
  def change
    create_table :curated_tours do |t|
      t.string :tour_author
      t.string :tour_name

      t.timestamps
    end
  end
end
