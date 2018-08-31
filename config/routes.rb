Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resource :users, except: [:new, :destroy, :edit, :create, :update] do
        post :register
        post :login
      end

      resource :transfer, except: [:new, :show, :destroy, :edit, :create, :update] do
        post :transfer
      end

      resource :account, except: [:new, :show, :destroy, :edit, :create, :update] do
        post :top_up
        post :report
      end
    end
  end
end
