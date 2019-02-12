class CreateLocationsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :city
      t.string :country
      t.float :longitude
      t.float :latitude
      t.timestamps
    end
  end
end
