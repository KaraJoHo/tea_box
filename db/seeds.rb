require "factory_bot_rails"
include FactoryBot::Syntax::Methods

customer = create(:customer)
tea_1 = create(:tea)
tea_2 = create(:tea)
subscription_1 = create(:subscription, tea_id: tea_1.id, customer_id: customer.id)
subscription_2 = create(:subscription, tea_id: tea_2.id, customer_id: customer.id)