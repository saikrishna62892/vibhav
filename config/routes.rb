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
   get '/blacklist' => 'admin#blacklist', as: 'blacklist'
   get '/edit'=>'admin#edit' ,as: 'edit'
   get '/delete'=>'admin#delete' ,as: 'delete'
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
   resources :posts
   resources :vegetables
   match ':controller(/:action(/:id(.:format)))', :via => [:get,:post]
end
