class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :text
      t.date :date

      t.timestamps
    end
  end
end
