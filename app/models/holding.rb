class Holding < ApplicationRecord
  belongs_to :portfolio
  belongs_to :coin
  
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :purchase_price, presence: true, numericality: { greater_than: 0 }
end