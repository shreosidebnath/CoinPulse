puts "Creating coins..."

service = CoingeckoService.new
coins_data = service.fetch_top_coins(10)

if coins_data
  coins_data.each do |coin_data|
    coin = Coin.find_or_create_by(coingecko_id: coin_data['id']) do |c|
      c.name = coin_data['name']
      c.symbol = coin_data['symbol']
      c.current_price = coin_data['current_price']
    end
    
    # Create initial price snapshot
    PriceSnapshot.create!(
      coin: coin,
      price: coin_data['current_price'],
      recorded_at: Time.current
    )
    
    puts "Created #{coin.name} (#{coin.symbol.upcase})"
  end
  
  puts "✓ Created #{Coin.count} coins!"
else
  puts "✗ Failed to fetch coins from CoinGecko"
end