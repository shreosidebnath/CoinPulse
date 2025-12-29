class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @portfolios = current_user.portfolios.includes(holdings: [:coin, { coin: :price_snapshots }])
    @coins = Coin.all
    @total_value = calculate_total_value
  end

  private

  def calculate_total_value
    return 0 unless current_user.portfolios.any?
    
    current_user.portfolios.sum do |portfolio|
      portfolio.holdings.sum do |holding|
        latest_price = holding.coin.price_snapshots.order(recorded_at: :desc).first&.price || holding.coin.current_price || 0
        holding.amount * latest_price
      end
    end
  end
end