class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :inventory, default: 0
      t.integer :sales_price_in_cents, default: 0
      t.integer :msrp_in_cents, default: 0

      t.timestamps
    end
  end
end
