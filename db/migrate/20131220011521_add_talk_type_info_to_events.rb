class AddTalkTypeInfoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :talks_type, :string
    add_column :events, :talks_duration, :integer
    add_column :events, :talks_slots, :integer
  end
end
