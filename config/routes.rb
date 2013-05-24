PointlessFeedback::Engine.routes.draw do
  root :to => 'messages#new'

  resources :messages, :only => [:new, :create]
end
