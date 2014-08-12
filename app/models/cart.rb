class Cart < ActiveRecord::Base
  has_many :cart_items

  def total
    cart_items.map(&:total).sum
  end

  def total_in_cents
    (total * 100).to_i
  end
end
