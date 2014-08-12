Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root to: "home#index"
  post "/cart/:book_id" => "home#add_to_cart", as: :add_to_cart
  get "/cart" => "home#cart", as: :show_cart
  patch "/cart/items/:cart_item_id" => "home#update_quantity", as: :update_cart_item
  post "/charge" => "home#charge"

  get "/receipts/:stripe_charge_id" => "home#receipt" , as: :receipt

end
