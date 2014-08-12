class HomeController < ApplicationController
  def index
    @books = Book.all
  end

  def cart
    # get books from cart
    # show the books
    @cart = find_cart
  end

  def add_to_cart
    # find book from params[:book_id]
    book = Book.find(params[:book_id])

    # find the cart
    cart = find_cart

    # add to cart
    cart.cart_items.create quantity: 1, book: book


    # redirect_to show cart page
    redirect_to show_cart_path

  end

  def update_quantity
    cart_item = CartItem.find(params[:cart_item_id])
    # "cart_item"=>{"quantity"=>"2"},
    # {"quantity"=>"2"}
    cart_item.update(params.require(:cart_item).permit(:quantity))
    cart.save
  end

  def find_cart
    if session[:cart_id].present?
      cart = Cart.find(session[:cart_id])
    else
      cart = Cart.create!
      session[:cart_id] = cart.id
    end
    cart
  end
end
