Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources "groups" do
    resources "posts" do
      resources "comments" do
        get "reply"
      end
    end
    get "join_member"
    delete "remove_member"
  end

  root to: "groups#index"
end
