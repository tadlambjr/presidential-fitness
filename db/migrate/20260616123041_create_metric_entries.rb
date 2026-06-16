class CreateMetricEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :metric_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.date :recorded_on
      t.decimal :broad_jump_inches
      t.decimal :throw_distance_inches
      t.integer :push_ups
      t.integer :sit_ups
      t.integer :chin_ups
      t.integer :pull_ups
      t.integer :handstand_seconds
      t.decimal :flexibility_inches
      t.decimal :fifty_yard_dash_seconds
      t.integer :one_mile_run_seconds
      t.decimal :shuttle_run_seconds
      t.integer :rope_climb_seconds
      t.decimal :vertical_jump_inches
      t.text :notes

      t.timestamps
    end
  end
end
