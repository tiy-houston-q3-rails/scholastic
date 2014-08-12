class Book < ActiveRecord::Base

  mount_uploader :image, PhotoUploader

  def price
    sales_price_in_cents / 100.0
  end

  def msrp
    msrp_in_cents / 100.0
  end

  def percent_off
    (msrp - price) / msrp * 100.0
  end
end
