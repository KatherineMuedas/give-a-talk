class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :street_address
      t.string :secondary_address
      t.string :city
      t.string :region
      t.string :postal_code
      t.string :country
      t.text :instructions
      t.string :map
      t.string :url
      t.references :locateable, index: true, polymorphic: true
      t.string :slug, unique: true, index: true

      t.timestamps
    end
  end
end
