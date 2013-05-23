PointlessFeedback::Engine.routes.draw do
  root :to => 'feedbacks#new'

  resources :feedbacks, :only => [:new, :create]
end
