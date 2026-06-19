class CreateMetrics < ActiveRecord::Migration[8.1]
  def change
    create_table :metrics do |t|
      t.string :name
      t.string :instructions
      t.string :measures
      t.string :unit
      t.string :boys_90pct
      t.string :girls_90pct
      t.text :notes

      t.timestamps
    end
  end
end
