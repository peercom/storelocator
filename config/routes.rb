Storefinder::Application.routes.draw do
  devise_for :admins

  resources :stores

  root :to => 'stores#index'
end
