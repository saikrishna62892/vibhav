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
   post '/register' => 'posts#register'
   post '/validate' => 'posts#validate'
   post '/order' => 'posts#order'
   post '/new' => 'admin#new'
   get '/add' => 'admin#add'
   get '/new' => 'admin#index'
   post '/attempt_login' => 'admin#attempt_login'
   post '/attempt_ulogin' => 'posts#attempt_ulogin'
   get '/posts/forgot_collegeid' => 'posts#forgot_collegeid', as: 'forgot_collegeid'
   get '/posts/forgot_password' => 'posts#forgot_password', as: 'forgot_password'
   resources :posts
   match ':controller(/:action(/:id(.:format)))', :via => [:get,:post]
end
