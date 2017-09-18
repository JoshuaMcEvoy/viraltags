class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.date :created_at
      t.text :text
      t.text :screen_name
      t.text :profile_image_url

      t.timestamps
    end
  end
end
