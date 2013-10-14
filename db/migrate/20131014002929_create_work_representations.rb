class CreateWorkRepresentations < ActiveRecord::Migration
  def change
    create_table :work_representations do |t|
      t.text :url
      t.text :fileext
      t.text :text_body_markdown
      t.belongs_to :work

      t.timestamps
    end
  end
end
