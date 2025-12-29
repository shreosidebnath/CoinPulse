class HoldingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portfolio

  def create
    @holding = @portfolio.holdings.build(holding_params)
    
    if @holding.save
      redirect_to root_path, notice: "✅ Holding added successfully!"
    else
      redirect_to root_path, alert: "❌ Error: #{@holding.errors.full_messages.join(', ')}"
    end
  rescue => e
    redirect_to root_path, alert: "❌ Failed to add holding: #{e.message}"
  end

  def destroy
    @holding = @portfolio.holdings.find(params[:id])
    @holding.destroy
    redirect_to root_path, notice: "Holding removed successfully!"
  end

  private

  def set_portfolio
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
  end

  def holding_params
    params.permit(:coin_id, :amount, :purchase_price)
  end
end