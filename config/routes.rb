Csas::Application.routes.draw do


  patch 'players/:id/request' => 'players#propose', as: :request_campaign_participation
  patch 'players/:id/accept' => 'players#accept', as: :accept_campaign_request
  patch 'players/:id/reject' => 'players#reject', as: :reject_campaign_request
  patch 'players/:id/remove' => 'players#remove', as: :remove_campaign_participation

  patch 'campaign_character/:id/join' => 'campaign_characters#join', as: :join_cc
  patch 'campaign_character/:id/kill' => 'campaign_characters#kill', as: :kill_cc
  patch 'campaign_character/:id/retire' => 'campaign_characters#retire', as: :retire_cc
  patch 'campaign_character/:id/lose' => 'campaign_characters#lose', as: :lose_cc

  resources :players

  resources :campaigns
  resources :campaign_characters
  resources :character_templates
  resources :resources
  resources :attachments
  resources :games
  resources :versions
  root 'welcome#index'

  devise_for :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
