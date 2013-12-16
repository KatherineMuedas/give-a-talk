class AddFriendlyIdSlugsToExistingColumns < ActiveRecord::Migration
  def change
    add_column :events, :slug, :string
    add_index :events, :slug, unique: true

    add_column :organizations, :slug, :string
    add_index :organizations, :slug, unique: true

    add_column :talks, :slug, :string
    add_index :talks, :slug, unique: true    

    add_column :users, :slug, :string
    add_index :users, :slug, unique: true
  end
end
