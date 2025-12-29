class Coin < ApplicationRecord
  has_many :holdings
  has_many :price_snapshots
  
  validates :coingecko_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :symbol, presence: true
end