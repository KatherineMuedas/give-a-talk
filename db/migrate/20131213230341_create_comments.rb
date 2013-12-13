class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :reply_to_id
      t.references :user, index: true
      t.references :commentable, index: true, polymorphic: true

      t.timestamps
    end
  end
end
