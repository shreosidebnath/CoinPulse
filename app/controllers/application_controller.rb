def setup
  # Only allow this once
  if Coin.count > 0
    render plain: "✓ Database already seeded! #{Coin.count} coins exist."
    return
  end

  begin
    # Seed coins
    service = CoingeckoService.new
    coins_data = service.fetch_top_coins(10)

    if coins_data && coins_data.is_a?(Array)
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
      render plain: "API returned invalid data. Response: #{coins_data.inspect}"
    end
  rescue => e
    render plain: "Error: #{e.class} - #{e.message}\n\nBacktrace:\n#{e.backtrace.first(5).join("\n")}"
  end
end