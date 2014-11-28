class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :attachment
      t.text :description
      t.references :imageable, polymorphic: true

      t.timestamps
    end
  end
end
