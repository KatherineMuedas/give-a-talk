class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.string :website
      t.text :about

      t.timestamps
    end
  end
end
