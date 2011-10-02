Seadu::Application.routes.draw do

  root :to => "homepage#index"
  
  resources :rooms
  resources :vibes
  match 'vibes/create/:room_id/:vibe_type' => 'vibes#create', :as => :create_vibe
  match 'vibes/randomize_chart/:room_id' => 'vibes#randomize_chart', :as => :randomize_chart
  
  match 'questions/most_recent' => 'questions#most_recent', :as => 'most_recent_questions'
  match 'questions/highest_rated' => 'questions#highest_rated', :as => 'highest_rated_questions'
  match 'questions/newly_created' => 'questions#newly_created', :as => 'newly_created_questions'
  match 'questions/:id/vote' => 'questions#vote', :as => 'question_vote', :method => :post
  resources :questions
  resources :votes
  
  match "signup" => "teachers#new", :as => "new_teachers"
  resource :teachers
  
  match "login" => "teacher_sessions#new", :as => "new_teacher_sessions"
  resource :teacher_sessions
  
  match 'teachers/view/:room_id' => 'teachers#view', :as => :teachers_view
  match 'students/view/:room_id' => 'students#view', :as => :students_view
  
  match 'sms' => 'sms#sms', :as => :sms
  match 'vibes/chart/data/:room_id' => 'vibes#chart_data', :as => :vibes_chart_data
  match 'vibes/chart/:room_id' => 'vibes#chart', :as => :vibes_chart

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
  match ':controller(/:action(/:id(.:format)))'
end
