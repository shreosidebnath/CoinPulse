class PriceSnapshot < ApplicationRecord
  belongs_to :coin
  
  validates :price, presence: true
  validates :recorded_at, presence: true
  
  scope :recent, -> { order(recorded_at: :desc) }
end