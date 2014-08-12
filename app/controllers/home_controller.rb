class HomeController < ApplicationController
  def index
    @books = Book.all
  end

  def cart
    # get books from cart
    # show the books
  end

  def add_to_cart
    # find book from params[:book_id]
    book = Book.find(params[:book_id])

    # add to cart

    # redirect_to show cart page
    redirect_to show_cart_path

  end
end
