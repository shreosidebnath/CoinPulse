class CoingeckoService
  include HTTParty
  base_uri 'https://api.coingecko.com/api/v3'

  def fetch_price(coin_id)
    response = self.class.get("/simple/price", query: {
      ids: coin_id,
      vs_currencies: 'usd'
    })
    
    response.dig(coin_id, 'usd') if response.success?
  end

  def fetch_top_coins(limit = 20)
    response = self.class.get('/coins/markets', query: {
      vs_currency: 'usd',
      order: 'market_cap_desc',
      per_page: limit,
      page: 1
    })
    
    response.parsed_response if response.success?
  end
end