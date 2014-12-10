class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :value, default: 0
      t.references :user, index: true
      t.references :voting, polymorphic: true

      t.timestamps
    end
  end
end
