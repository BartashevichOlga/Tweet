Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "extended/omniauth_callbacks" }
  root 'tweet#index'

end
