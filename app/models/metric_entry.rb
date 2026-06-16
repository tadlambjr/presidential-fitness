class MetricEntry < ApplicationRecord
  belongs_to :user
  validates :recorded_on, presence: true

  scope :chronological, -> { order(recorded_on: :desc) }
end
