Rails.application.routes.draw do
  root to: 'pages#home'
  get 'pages/home'
  get '/auth/:provider/callback', to: 'pages#home'
end
