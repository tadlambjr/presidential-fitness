class RemoveSitAndReachFromMetricEntries < ActiveRecord::Migration[8.1]
  def change
    remove_column :metric_entries, :flexibility_inches
  end
end
