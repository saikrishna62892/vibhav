Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   root 'posts#index'
   get '/index'=>'posts#index' ,as: 'home'
   get '/admin' => 'admin#index', as: 'admin'
   get '/signup' => 'posts#signup', as: 'signup'
   get '/login' => 'posts#login', as: 'login'
   get '/booking' => 'posts#booking', as: 'booking'
   get '/cancel' => 'posts#cancel', as: 'cancel'
   get '/logout' => 'posts#logout', as: 'logout'
   get '/status' => 'admin#status', as: 'status'
   get '/status_done/:id' => 'admin#status_done', as: 'status_done'
    get 'closeshop' => 'admin#closeshop', as: 'closeshop'
   get '/bookingdelete/:id' => 'posts#bookingdelete', as: 'bookingdelete'
   get '/blacklist' => 'admin#blacklist', as: 'blacklist'
   get '/reg_users' => 'admin#reg_users', as: 'reg_users'
   get '/user_remove/:id' => 'admin#user_remove', as: 'user_remove'
   get '/patch/:id'=>'admin#patch' ,as: 'patch'
   get '/edit/:id'=>'admin#edit' ,as: 'edit'
   patch '/vegetables/:id'=>'admin#update',as: 'vegetable'
   delete '/delete/:id'=>'admin#delete' ,as: 'delete'
   get '/register' => 'posts#register'
   post '/register' => 'posts#register'
   post '/order' => 'posts#order'
   post '/new' => 'admin#new'
   get '/add' => 'admin#add'
   get '/new' => 'admin#index'
   post '/attempt_login' => 'admin#attempt_login'
   post '/attempt_ulogin' => 'posts#attempt_ulogin'
   post '/forgot_form' => 'posts#forgot_form'
   get '/forgot' => 'posts#forgot'
   post '/add_veg' => 'admin#add_veg'
   post '/book_veg' => 'posts#book_veg'
   get '/confirm' => 'posts#confirm'
   resources :posts
   
   #resources :vegetables
   match ':controller(/:action(/:id(.:format)))', :via => [:get,:post]
end
