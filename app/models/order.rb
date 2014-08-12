class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  def total
    line_items.map(&:total).sum
  end
end
