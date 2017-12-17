Rails.application.routes.draw do

  devise_for :users

  resources :users do
    resources :pictures
  end

  resources :pictures do
    resources :comments
  end

  resources :pictures do
    member do
      put "like", to: "pictures#upvote"
      put "dislike", to: "pictures#downvote"
    end
  end

  resources :comments do
    member do
      put "like", to: "comments#upvote"
      put "dislike", to: "comments#downvote"
    end
  end


  root 'pictures#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
