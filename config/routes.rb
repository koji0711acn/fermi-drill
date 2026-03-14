Rails.application.routes.draw do
  devise_for :users

  root "pages#top"

  get "dashboard", to: "dashboard#show"

  resources :fermi_questions, only: [:index, :show] do
    resources :fermi_attempts, only: [:new, :create], path: "attempts"
  end

  resources :fermi_attempts, only: [:index, :show], path: "attempts" do
    member do
      post :retry_evaluation
      get :status
    end
  end

  # Weak category focused drill
  get "drill/weakness", to: "drill#weakness", as: :weakness_drill

  get "up" => "rails/health#show", as: :rails_health_check
end
