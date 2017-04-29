Rails.application.routes.draw do
  root to: 'reviews#index'
  get 'get_reviews', to: 'reviews#get_reviews', as: 'get_reviews'
  get 'narrow_down_suggestions', to: 'reviews#narrow_down_suggestions', as: 'narrow_down_suggestions'
end
