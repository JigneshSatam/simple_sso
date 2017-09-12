SimpleSso::Engine.routes.draw do
  resources :authentications, only: [] do
    collection do
      get 'login'
      get 'logout'
      get 'keep_alive'
      delete 'logout'
    end
  end
end
