Rails.application.routes.draw do
  get 'home/index'
  get 'home/show'
  devise_for :users
  root "home#index"
  get 'albums/draft'
  resources :albums 
  delete "attachments/:id/purge" , to: "attachments#purge" ,as: "purge_attachment"


  resources :home do
    collection do
      match 'search' => 'home#search', via: [:get, :post], as: :search
    end
  end
  
  get 'search',to: 'albums#search'



end
