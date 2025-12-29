class SessionsController < ApplicationController
  def demo
    # Find or create demo user
    demo_user = User.find_or_create_by(email: 'demo@coinpulse.com') do |user|
      user.password = 'demo1234'
      user.password_confirmation = 'demo1234'
    end
    
    # Create demo portfolio if it doesn't exist
    unless demo_user.portfolios.exists?
      portfolio = demo_user.portfolios.create!(name: 'Demo Portfolio')
      
      # Add some demo holdings
      bitcoin = Coin.find_by(symbol: 'btc')
      ethereum = Coin.find_by(symbol: 'eth')
      
      if bitcoin
        portfolio.holdings.create!(
          coin: bitcoin,
          amount: 0.5,
          purchase_price: bitcoin.current_price * 0.9
        )
      end
      
      if ethereum
        portfolio.holdings.create!(
          coin: ethereum,
          amount: 2.5,
          purchase_price: ethereum.current_price * 0.85
        )
      end
    end
    
    # Sign in the demo user
    sign_in(demo_user)
    redirect_to root_path, notice: '🎮 Welcome to the demo! This is a sample portfolio.'
  end
end