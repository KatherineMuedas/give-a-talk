class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :begins_at
      t.datetime :ends_at
      t.string :website
      t.references :eventable, index: true, polymorphic: true

      t.timestamps
    end
  end
end
