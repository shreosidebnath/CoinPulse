class ApplicationController < ActionController::Base
  def setup
    # Only allow this once
    if Coin.count > 0
      render plain: "✓ Database already seeded! #{Coin.count} coins exist."
      return
    end

    # Seed coins
    service = CoingeckoService.new
    coins_data = service.fetch_top_coins(10)

    if coins_data
      coins_data.each do |coin_data|
        coin = Coin.create!(
          coingecko_id: coin_data['id'],
          name: coin_data['name'],
          symbol: coin_data['symbol'],
          current_price: coin_data['current_price']
        )
        
        PriceSnapshot.create!(
          coin: coin,
          price: coin_data['current_price'],
          recorded_at: Time.current
        )
      end
      
      render plain: "Success! Created #{Coin.count} coins. Go to homepage now!"
    else
      render plain: "Failed to fetch coins from CoinGecko API"
    end
  end
end