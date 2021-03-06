HomeworkNotifier::Application.routes.draw do

  root :to => 'application#index'
  resources :groups do
    collection do
      post "receive_message"
      post "receive_email"
    end
    member do
      post "send_message", :as=>:send_message_to
      post "bulk_upload_students"
    end
    resources :students do
      #post "send_message", :as=>:send_message_to #possibly add in future
    end
  end
  resources :students

  # devise_for :users
  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register'}, :controllers=>{:registrations=>"registrations"}
  devise_for :admins

  as :user do
    scope "/users" do
      resource :profile, :controller=>"registrations", :only=>[:edit,:update] do
        get "edit_password", :as=>"edit_password_of"
      end
    end
  end

  resources :users

  get "/welcome" => "users#splash"  

  # devise_for :admins, :controllers => { :sessions => "admins/sessions" }

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
