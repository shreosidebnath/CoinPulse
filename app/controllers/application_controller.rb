class ApplicationController < ActionController::Base
  def setup
    if Coin.count > 0
      render plain: "✓ Database already seeded! #{Coin.count} coins exist."
      return
    end

    begin
      fallback_coins = [
        { id: 'bitcoin', name: 'Bitcoin', symbol: 'btc', price: 95000 },
        { id: 'ethereum', name: 'Ethereum', symbol: 'eth', price: 3500 },
        { id: 'tether', name: 'Tether', symbol: 'usdt', price: 1.0 },
        { id: 'binancecoin', name: 'BNB', symbol: 'bnb', price: 690 },
        { id: 'ripple', name: 'XRP', symbol: 'xrp', price: 2.25 },
        { id: 'usd-coin', name: 'USDC', symbol: 'usdc', price: 1.0 },
        { id: 'solana', name: 'Solana', symbol: 'sol', price: 195 },
        { id: 'tron', name: 'TRON', symbol: 'trx', price: 0.25 },
        { id: 'cardano', name: 'Cardano', symbol: 'ada', price: 0.95 },
        { id: 'dogecoin', name: 'Dogecoin', symbol: 'doge', price: 0.32 }
      ]

      service = CoingeckoService.new
      coins_data = service.fetch_top_coins(10)

      unless coins_data && coins_data.is_a?(Array)
        coins_data = fallback_coins.map do |coin|
          { 'id' => coin[:id], 'name' => coin[:name], 'symbol' => coin[:symbol], 'current_price' => coin[:price] }
        end
      end

      coins_data.each do |coin_data|
        coin = Coin.create!(
          coingecko_id: coin_data['id'],
          name: coin_data['name'],
          symbol: coin_data['symbol'],
          current_price: coin_data['current_price']
        )
        
        # Create 24 hours of historical data
        24.times do |i|
          variation = rand(-5.0..5.0) / 100.0
          PriceSnapshot.create!(
            coin: coin,
            price: coin_data['current_price'] * (1 + variation),
            recorded_at: i.hours.ago
          )
        end
      end
      
      render plain: "Success! Created #{Coin.count} coins with historical data. Go to homepage!"
    rescue => e
      render plain: "Error: #{e.class} - #{e.message}"
    end
  end
end