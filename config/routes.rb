SurveyWeb::Application.routes.draw do  

  scope "(:locale)", :locale => /#{I18n.available_locales.join('|')}/ do
    match '/auth/:provider/callback', :to => 'sessions#create'
    match '/auth/failure', :to => 'sessions#failure'
    match '/logout', :to => 'sessions#destroy', :as => 'logout'

    match '/surveys/build/:id', :to => 'surveys#build', :as => "surveys_build"

    resources :surveys,:only => [:new, :create, :destroy, :index] do
      member { post "duplicate" } 
      get 'publish_to_users', 'share_with_organizations'
      put 'update_publish_to_users', 'update_share_with_organizations'
      resources :responses, :only => [:new, :create, :index, :edit, :update] do
        member { put "complete" }
      end
    end

    root :to => 'surveys#index'
  end

  namespace :api, :defaults => { :format => 'json' } do
    scope :module => :v1 do
      resources :questions, :except => [:edit, :new]
      resources :options, :except => [:edit, :new, :show]
      resources :surveys, :only => [:index, :show, :update]
      resources :responses, :only => [:create, :update]
      post 'questions/:id/image_upload' => 'questions#image_upload'
    end
  end
end
