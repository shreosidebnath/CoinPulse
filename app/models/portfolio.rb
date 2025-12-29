class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :holdings, dependent: :destroy
  has_many :coins, through: :holdings
  
  validates :name, presence: true
end