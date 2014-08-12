class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :stripe_charge_id
      t.references :user, index: true

      t.timestamps
    end
  end
end
