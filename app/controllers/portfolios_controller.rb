class PortfoliosController < ApplicationController
  before_action :authenticate_user!

  def index
    @portfolios = current_user.portfolios
  end

  def show
    @portfolio = current_user.portfolios.find(params[:id])
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = current_user.portfolios.build(portfolio_params)
    
    if @portfolio.save
      redirect_to root_path, notice: "Portfolio created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:name)
  end
end