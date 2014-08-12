class HomeController < ApplicationController

  skip_before_filter :verify_authenticity_token, only: [:charge]

  def index
    @books = Book.all
  end

  def charge

    cart = find_cart

    Stripe.api_key = "sk_test_4ZTpoMNU3PGxXxKgxlIW0sXA"

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => cart.total_in_cents, # amount in cents, again
        :currency => "usd",
        :card => token,
        :description => "Scholastic Books"
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end

    # 1. create charge
    # 2. create order
    @order = Order.new(stripe_charge_id: charge.id)
    cart.cart_items.each do |ci|
      @order.line_items.build(book: ci.book, quantity: ci.quantity, price_paid_in_cents: ci.book.sales_price_in_cents)
    end
    @order.save

    # 3. remove cart
    session[:cart_id] = nil
    cart.destroy

    # 4. update inventory
    @order.line_items.each do |li|
      quantity_new = li.book.inventory - li.quantity
      li.book.update(inventory: quantity_new)
    end

    redirect_to receipt_path(stripe_charge_id: @order.stripe_charge_id)


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

  def receipt
    @order = Order.find_by stripe_charge_id: params[:stripe_charge_id]
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
