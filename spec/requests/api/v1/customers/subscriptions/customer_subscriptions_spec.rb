require "rails_helper"

RSpec.describe "Customer's Subscriptions" do 
  describe "customer subscriptions" do 
    it "can see all of a customer's subscriptions(active and cancelled)" do 
      customer = create(:customer)
      teas = create_list(:tea, 2)
      sub_1 = create(:subscription, status: "active", tea_id: teas[0].id, customer_id: customer.id)
      sub_2 = create(:subscription, status: "cancelled", tea_id: teas[1].id, customer_id: customer.id)
      
      get "/api/v1/customers/#{customer.id}/subscriptions"

      customer_subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(customer_subscriptions[:data]).to have_key(:type)
      expect(customer_subscriptions[:data][:type]).to eq("customer")
      expect(customer_subscriptions[:data][:attributes]).to have_key(:subscriptions)
      expect(customer_subscriptions[:data][:attributes][:subscriptions]).to be_an(Array)
      expect(customer_subscriptions[:data][:attributes][:subscriptions].count).to eq(2)
      expect(customer_subscriptions[:data][:attributes][:subscriptions][0].keys).to eq([:id, :customer_id, :tea_id, :status, :frequency, :title, :price, :created_at, :updated_at])
    end

    it "can cancel a customer's tea subscription" do 
      customer = create(:customer)
      teas = create_list(:tea, 2)
      sub_1 = create(:subscription, status: "active", tea_id: teas[0].id, customer_id: customer.id)
      sub_2 = create(:subscription, status: "cancelled", tea_id: teas[1].id, customer_id: customer.id)

      update_params = {
        status: "cancelled"
      }

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{sub_1.id}", headers: headers, params: JSON.generate(subscription: update_params)

      updated_parsed = JSON.parse(response.body, symbolize_names: true)
      updated_subscription = Subscription.find(sub_1.id)
      
      expect(response).to be_successful
      expect(updated_subscription.status).to eq("cancelled")
    end
  end
end