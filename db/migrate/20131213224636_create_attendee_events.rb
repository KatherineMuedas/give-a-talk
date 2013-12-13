class CreateAttendeeEvents < ActiveRecord::Migration
  def change
    create_table :attendee_events do |t|
      t.references :user, index: true
      t.references :event, index: true

      t.timestamps
    end
  end
end
