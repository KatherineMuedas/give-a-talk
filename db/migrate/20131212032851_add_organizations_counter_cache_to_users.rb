class AddOrganizationsCounterCacheToUsers < ActiveRecord::Migration
  def change
    add_column :users, :organizations_count, :integer, default: 0
  end
end
