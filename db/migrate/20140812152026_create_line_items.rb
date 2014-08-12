class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :quantity
      t.integer :price_paid_in_cents
      t.references :order, index: true
      t.references :book, index: true

      t.timestamps
    end
  end
end
