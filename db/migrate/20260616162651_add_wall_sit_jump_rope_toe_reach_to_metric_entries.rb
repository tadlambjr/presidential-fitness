class AddWallSitJumpRopeToeReachToMetricEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :metric_entries, :wall_sit_seconds, :integer
    add_column :metric_entries, :jump_rope_reps, :integer
    add_column :metric_entries, :toe_reach_inches, :decimal
  end
end
