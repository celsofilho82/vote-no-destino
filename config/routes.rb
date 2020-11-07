Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'destinations#home'
  get 'primeiro_destino', to: 'destinations#primeiro_destino'
  get 'segundo_destino', to: 'destinations#segundo_destino'
  patch 'up-vote', to: 'destinations#up_vote'
end
