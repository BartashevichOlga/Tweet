Rails.application.routes.draw do

  post 'tweet', to: 'tweet#post_tweet', as: 'post_tweet'
  devise_for :users, controllers: { omniauth_callbacks: "extended/omniauth_callbacks" }
  root 'tweet#index'
end
