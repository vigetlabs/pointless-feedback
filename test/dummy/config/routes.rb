Rails.application.routes.draw do
  mount PointlessFeedback::Engine => "/pointless_feedback"

  root :to => 'home#index'
end
