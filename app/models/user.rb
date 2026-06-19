class User < ApplicationRecord
  has_secure_password
  has_many :metric_entries, dependent: :destroy
  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true, allow_nil: true
end
