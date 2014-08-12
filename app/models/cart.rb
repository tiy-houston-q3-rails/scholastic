class Cart < ActiveRecord::Base
  has_many :cart_items

  def total
    cart_items.map(&:total).sum
  end
end
