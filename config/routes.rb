Rails.application.routes.draw do
  get  'posts/index'
  root 'posts#index'
  resources :posts do
    member do
      patch "upvote", to: "posts#upvote"
      patch "downvote", to: "posts#downvote"
    end
  end 
end
