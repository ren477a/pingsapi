class Device < ApplicationRecord
  has_many :pings
  validates :device_id, presence: true
end
