class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.references :book, index: true
      t.references :cart, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
