Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  get 'home/index'
  get 'home/show'
  get 'albums/draft'
  get 'albums/admin'
  resources :albums 
  delete "attachments/:id/purge" , to: "attachments#purge" ,as: "purge_attachment"
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user


  resources :home do
    collection do
      match 'search', to: 'home#search', via: [:get, :post], as: :search
    end
  end
  
  get 'search',to: 'albums#search'



end
