require 'resque'
require 'resque/server'

module Routes
  class PublicControllerConstraint
    def initialize
      @lookup_context = ActionView::LookupContext.new(ApplicationController.view_paths)
    end

    def matches?(request)
      @lookup_context.template_exists?([request.params[:section], request.params[:page]].compact.join('/').downcase)
    end
  end
end

MarlinSearcher::Application.routes.draw do
  mount Resque::Server.new, :at => "/resque-tasks"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  root :to => 'home#index'

  post 'search' => 'home#search', :as => :search
  post 'reserve' => 'home#reserve', :as => :reserve

  get 'login' => 'home#new_session', :as => :login
  post 'login' => 'home#create_session', :as => :create_session

  controller :home, :path => '/' do
    get '/:section(/:page)', :action => :custom, :as => :public,
    :constraints => Routes::PublicControllerConstraint.new
  end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
