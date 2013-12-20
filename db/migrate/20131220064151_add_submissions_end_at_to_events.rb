class AddSubmissionsEndAtToEvents < ActiveRecord::Migration
  def change
    add_column :events, :submissions_end_at, :datetime
  end
end
