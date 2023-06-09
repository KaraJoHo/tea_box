class Subscription < ApplicationRecord 
  belongs_to :tea
  belongs_to :customer

  validates_presence_of :title, :status, :frequency, :price
end