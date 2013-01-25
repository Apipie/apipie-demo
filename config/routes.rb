Demo::Application.routes.draw do
  apipie

  resources :users, except: [:new, :edit] do
    resources :tweets, except: [:new, :edit]
  end
end
