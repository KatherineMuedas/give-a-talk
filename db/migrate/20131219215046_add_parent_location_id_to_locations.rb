class AddParentLocationIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :parent_location_id, :integer
  end
end
