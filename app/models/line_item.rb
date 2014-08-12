class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :book

  def price
    price_paid_in_cents / 100.0
  end

  def total
    price_paid_in_cents * quantity/ 100.0
  end
end
