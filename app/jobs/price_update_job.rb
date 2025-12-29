class PriceUpdateJob < ApplicationJob
  queue_as :default

  def perform
    service = CoingeckoService.new
    
    Coin.find_each do |coin|
      begin
        price = service.fetch_price(coin.coingecko_id)
        
        if price
          # Update current price on coin
          coin.update(current_price: price)
          
          # Create price snapshot for historical data
          PriceSnapshot.create!(
            coin: coin,
            price: price,
            recorded_at: Time.current
          )
          
          Rails.logger.info "Updated #{coin.name}: $#{price}"
        end
      rescue => e
        Rails.logger.error "Failed to update #{coin.name}: #{e.message}"
      end
    end
  end
end