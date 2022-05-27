# frozen_string_literal: true

Rails.application.routes.draw do
  resources :contacts, only: %i[index show]
  get :logged_out, to: 'session#destroy'
  post :logged_in, to: 'session#create'
  get :login, to: 'session#new'
  get :register, to: 'users#new'
  resources :users
  root to: 'welcome#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
