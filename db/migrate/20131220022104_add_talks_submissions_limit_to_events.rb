class AddTalksSubmissionsLimitToEvents < ActiveRecord::Migration
  def change
    add_column :events, :talks_submissions_limit, :integer
  end
end
