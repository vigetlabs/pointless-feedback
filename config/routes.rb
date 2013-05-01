PointlessFeedback::Engine.routes.draw do
  resources :feedbacks, :only => [:new, :create]
end
