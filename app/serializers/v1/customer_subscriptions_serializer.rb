class V1::CustomerSubscriptionsSerializer 
  include JSONAPI::Serializer 
  set_type :customer
  attributes :subscriptions
end