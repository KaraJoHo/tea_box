require "rails_helper"

RSpec.describe "Customer's Subscriptions" do 
  describe "all customer's subscriptions" do 
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

    it "renders an error if the customer does not exist" do 
      get "/api/v1/customers/10000000/subscriptions"

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error.keys).to eq([:title, :errors])
      expect(error[:errors][0]).to eq("Couldn't find Customer with 'id'=10000000")
    end
  end 

  describe "Cancel subscription" do 
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

    it "renders an error if the subscription does not exist" do 
      customer = create(:customer)
      teas = create_list(:tea, 2)
      sub_1 = create(:subscription, status: "active", tea_id: teas[0].id, customer_id: customer.id)
      update_params = {status: "cancelled"}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customers/#{customer.id}/subscriptions/4444444", headers: headers, params: JSON.generate(subscription: update_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error.keys).to eq([:title, :errors])
      expect(error[:errors][0]).to eq("Couldn't find Subscription with 'id'=4444444")
    end

    it "renders an error if parameters are not provided" do 
      customer = create(:customer)
      teas = create_list(:tea, 2)
      sub_1 = create(:subscription, status: "active", tea_id: teas[0].id, customer_id: customer.id)
      update_params = {}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{sub_1.id}", headers: headers, params: JSON.generate(subscription: update_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error.keys).to eq([:title, :errors])
      expect(error[:errors][0]).to eq("param is missing or the value is empty: subscription")
    end
  end 

  describe "Create new subscription for customer" do
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

      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)
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

    it "renders an error if the customer and/or tea does not exist" do 
      customer = create(:customer)
      tea = create(:tea)
      subscription_params = {
        customer_id: 67676767676, 
        tea_id: 474747474747474,
        status: "active",
        frequency: "1 per month",
        title: tea.title,
        price: "$1.00"
      }
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription: subscription_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error.keys).to eq([:title, :errors])
      expect(error[:errors][0]).to eq("Validation failed: Tea must exist")
    end
  end
end