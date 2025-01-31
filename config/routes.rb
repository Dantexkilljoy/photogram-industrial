Rails.application.routes.draw do
  root "photos#index"
 
 

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
  resources :users, only: :show

  get "/:username" => "users#show"
end
