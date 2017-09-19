Rails.application.routes.draw do
  root to: 'pages#home'
  get 'pages/home'
  get '/auth/:provider/callback', to: 'pages#home'
  get 'pages/index'
  get 'pages/data', :defaults => {:format => 'json'}
  get '/pages/lookup' => 'pages#lookup'
  get '/pages/locationPicker' => 'pages#locationPicker'
  post '/pages/lookup' => 'pages#lookup'
end
