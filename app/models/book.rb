class Book < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search,
                  :against => [:title, :author],
                  :using => {
                    :tsearch => {
                      :prefix => true,
                      :dictionary => "english"
                      }
                  }

  mount_uploader :image, PhotoUploader

  def self.query(params)
    if params[:query].blank?
      Book.all
    else
      Book.search(params[:query])
    end
  end

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
