class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :longitude
      t.string :latitude
      t.integer :user_id
      t.text :address

      t.timestamps
    end
  end
end
