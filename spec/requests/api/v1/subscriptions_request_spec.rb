require "rails_helper"

RSpec.describe "Subscription Requests" do 
  describe "create subscription" do 
    it "can create a new subscription to a tea" do 
      customer = create(:customer)
      tea = create(:tea)

      subscription_params = {
        customer_id: customer.id, 
        tea_id: tea.id,
        status: "active",
        frequency: "1 per month",
        title: tea.title,
        price: "$1.00"
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)
      created_subscription = Subscription.last
      parsed_subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful 
      expect(created_subscription.title).to eq(subscription_params[:title])
      expect(created_subscription.status).to eq(subscription_params[:status])
      expect(created_subscription.price).to eq(subscription_params[:price])
      expect(created_subscription.frequency).to eq(subscription_params[:frequency])
      expect(parsed_subscription).to have_key(:data)
      expect(parsed_subscription[:data][:type]).to eq("subscription")
    end
  end
end