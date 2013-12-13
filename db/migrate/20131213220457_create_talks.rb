class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.string :talk_type
      t.string :title
      t.text :description
      t.text :justification
      t.string :video
      t.string :presentation
      t.string :status, default: "pending"
      t.hstore :resources
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
