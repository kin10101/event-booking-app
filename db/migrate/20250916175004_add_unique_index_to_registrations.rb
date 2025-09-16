class AddUniqueIndexToRegistrations < ActiveRecord::Migration[8.0]
  def change
    add_index :registrations, [:event_id, :attendee_email], unique: true
  end
end
