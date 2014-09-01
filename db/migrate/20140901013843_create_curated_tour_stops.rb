class CreateCuratedTourStops < ActiveRecord::Migration
  def change
    create_table :curated_tour_stops do |t|
      t.text :caption_text
      t.integer :sequential_id, index: true
      t.references :work, index: true
      t.references :curated_tour, index: true

      t.timestamps
    end
  end
end
