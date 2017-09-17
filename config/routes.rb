Rails.application.routes.draw do
  root to: 'pages#home'
  get 'pages/home'
<<<<<<< HEAD
  get '/auth/:provider/callback', to: 'pages#home'
=======
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'pages/index'
  get 'pages/data', :defaults => {:format => 'json'}
  get '/pages/lookup' => 'pages#lookup'
>>>>>>> 3a20a39105e38b81724d94fe1252ebe9db73bf25
end
