class Api::V1::SubscriptionsController < ApplicationController 
  def create 
    subscription = Subscription.create!(subscription_params)
    render json: V1::SubscriptionSerializer.new(subscription), status: :created
  end

  def index 
    customer = Customer.find(params[:customer_id])
    render json: V1::CustomerSubscriptionsSerializer.new(customer)
  end

  def update 
    subscription = Subscription.find(params[:id])
    subscription.update!(subscription_params)
    render json: V1::SubscriptionSerializer.new(subscription), status: 201
  end

  private 
    def subscription_params 
      params.require(:subscription).permit(:title, :status, :frequency, :price, :tea_id, :customer_id)
    end
end