class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      #t.integer :user_id
      #t.integer :image_id
      t.text :description
      t.references :user, index: true
      t.references :image, index: true

      t.timestamps
    end
  end
end
