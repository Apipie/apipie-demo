Demo::Application.routes.draw do
  apipie

  scope :module => :v1 do
    resources :users, except: [:new, :edit] do
      resources :tweets, except: [:new, :edit]
    end
  end

  scope :module => :v2 do
    resources :users, except: [:new, :edit] do
      resources :tweets, except: [:new, :edit]
    end
  end
end
