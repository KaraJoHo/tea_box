class V1::SubscriptionSerializer 
  include JSONAPI::Serializer 
  attributes :title, :status, :frequency, :price, :customer_id, :tea_id
end