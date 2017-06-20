Spina::Engine.routes.draw do
  namespace :admin do
    resources :blocks
  end
end
