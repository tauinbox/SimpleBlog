class AddSomeFieldsIntoProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :gender, :string
    add_column :profiles, :birthdate, :datetime
    add_column :profiles, :timezone, :string
  end
end
