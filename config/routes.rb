Rails.application.routes.draw do
  scope module: :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      devise_for :users, skip: [:sessions, :registrations, :confirmations, :passwords]
      as :user do
        post 'log-in', to: 'users/sessions#create'
        post 'sign-up', to: 'users/registrations#create'
        get 'confirm-email', to: 'users/confirmations#show'
        post 'resend-email', to: 'users/confirmations#create'
        post 'recover-password', to: 'users/passwords#create'
        put 'restore-password', to: 'users/passwords#update'
      end
    end
  end
end
