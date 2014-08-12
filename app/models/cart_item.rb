class CartItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :cart

  def total
    quantity * book.price
  end
end
