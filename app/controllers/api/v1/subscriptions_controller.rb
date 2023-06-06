class Api::V1::SubscriptionsController < ApplicationController 
  def create 
    subscription = Subscription.create!(subscription_params)
    render json: V1::SubscriptionSerializer.new(subscription), status: :created
  end

  private 
    def subscription_params 
      params.require(:subscription).permit(:title, :status, :frequency, :price, :tea_id, :customer_id)
    end
end