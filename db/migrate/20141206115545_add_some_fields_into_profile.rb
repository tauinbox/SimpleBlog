class AddSomeFieldsIntoProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :gender, :integer, default: 0
    add_column :profiles, :birthdate, :datetime
    add_column :profiles, :timezone, :integer
  end
end
