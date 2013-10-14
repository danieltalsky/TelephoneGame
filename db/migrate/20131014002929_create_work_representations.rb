class CreateWorkRepresentations < ActiveRecord::Migration
  def change
    create_table :work_representations do |t|
      t.text :url
      t.text :fileext
      t.belongs_to :work

      t.timestamps
    end
  end
end
