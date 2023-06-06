class CreateSubscription < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true
      t.string :status
      t.string :frequency
      t.string :title
      t.string :price

      t.timestamps
    end
  end
end
