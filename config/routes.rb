Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root to: "home#index"
  post "/cart/:book_id" => "home#add_to_cart", as: :add_to_cart
  get "/cart" => "home#cart", as: :show_cart
end
