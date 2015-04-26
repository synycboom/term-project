TermProject::Application.routes.draw do
  root to: 'exam_management#index'
  get "exam_management/index"
  get 'exam_management/about', :to => 'exam_management#about' , :as => 'about'
  get 'exam_management/show_managed_rooms', :to => 'exam_management#show_managed_rooms', :as => 'show_managed_rooms'
  get 'exam_management/show_all_subjects', :to => 'exam_management#show_all_subjects' , :as => 'show_all_subjects'
  get 'exam_management/show_all_locations', :to => 'exam_management#show_all_locations' , :as => 'show_all_locations'
  
  get 'exam_management/add_location_form', :to => 'exam_management#add_location_form' , :as => 'add_location_form'
  post 'exam_management/add_new_location', :to => 'exam_management#add_new_location' , :as => 'add_new_location'
  
  get 'exam_management/add_subject_form', :to => 'exam_management#add_subject_form' , :as => 'add_subject_form'
  post 'exam_management/add_new_subject', :to => 'exam_management#add_new_subject' , :as => 'add_new_subject'
  
  get 'exam_management/show_subject_detail', :to => 'exam_management#show_subject_detail' , :as => 'show_subject_detail'
  get 'exam_management/show_location_detail', :to => 'exam_management#show_location_detail' , :as => 'show_location_detail'
  
  get 'exam_management/edit_subject', :to => 'exam_management#edit_subject' , :as => 'edit_subject'
  put 'exam_management/update_s', :to => 'exam_management#update_s' , :as => 'update_s'
  
  get 'exam_management/edit_location', :to => 'exam_management#edit_location' , :as => 'edit_location'
  put 'exam_management/update_l', :to => 'exam_management#update_l' , :as => 'update_l'

  get 'exam_management/destroy_s', :to => 'exam_management#destroy_s' , :as => 'destroy_s'
  get 'exam_management/destroy_l', :to => 'exam_management#destroy_l' , :as => 'destroy_l'
  
  get 'exam_management/show_search_location', :to => 'exam_management#show_search_location' , :as => 'show_search_location'
  get 'exam_management/show_search_subject', :to => 'exam_management#show_search_subject' , :as => 'show_search_subject'
  
  get 'exam_management/manage_room', :to => 'exam_management#manage_room', :as => 'manage_room'
  get 'exam_management/generate_schedule_form', :to => 'exam_management#generate_schedule_form' , :as => 'generate_schedule_form'
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
