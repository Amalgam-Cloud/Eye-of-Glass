Rails.application.routes.draw do
  devise_for :users
  get 'persons/profile'
  devise_for :models
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :resumes, only: [:index, :new, :create, :destroy,:result,:change]
  root "resumes#index"
  get 'resumes/index'
  get 'resumes/create'
  get 'resumes/destroy'
  get 'resumes/result'
  get 'resumes/change'
  post 'resumes/change'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
