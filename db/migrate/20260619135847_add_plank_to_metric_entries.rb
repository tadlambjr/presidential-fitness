class AddPlankToMetricEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :metric_entries, :plank_seconds, :integer
  end
end
