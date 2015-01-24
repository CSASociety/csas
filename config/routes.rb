Csas::Application.routes.draw do


  resources :assistants
  resources :events
  patch 'players/:id/request' => 'players#propose', as: :request_campaign_participation
  patch 'players/:id/accept' => 'players#accept', as: :accept_campaign_request
  patch 'players/:id/reject' => 'players#reject', as: :reject_campaign_request
  patch 'players/:id/remove' => 'players#remove', as: :remove_campaign_participation

  patch 'player_character/:id/join' => 'player_characters#join', as: :join_pc
  patch 'player_character/:id/kill' => 'player_characters#kill', as: :kill_pc
  patch 'player_character/:id/retire' => 'player_characters#retire', as: :retire_pc
  patch 'player_character/:id/lose' => 'player_characters#lose', as: :lose_pc

  patch 'events/:id/attach_campaign' => "events#attach_campaign", as: :attach_campaign_to_event
  patch 'campaigns/:id/attach_event' => "campaigns#attach_event", as: :attach_event_to_campaign

  resources :players

  resources :campaigns
  resources :player_characters
  resources :characters
  resources :journal_entries
  resources :resources
  resources :attachments
  resources :games
  resources :versions
  resources :newsletters
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
