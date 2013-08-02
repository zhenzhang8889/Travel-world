Chatter::Application.routes.draw do
  
  resources :oauth_consumers do
    member do
      get :callback
      get :callback2
      match 'client/*endpoint' => 'oauth_consumers#client'
    end
  end

  devise_for :admins
  devise_for :users
  get "/threads/delete/:id" => 'message_thread#destroy_thread'
  get "/threads/archive/:id" => 'message_thread#archive_thread'
  put '/threads/change_subject/' => "message_thread#change_subject"
  get '/users/all' => 'home#allUsers'
  get "/knockout/" => 'home#knockout'
  get "/upload/:message_thread_id" => "messages#upload"
  get "users/sendmail"
   
  post "/upload" => "messages#uploaded"

  resources :lead_replies
  resources :members
  namespace :level2_admin do
    resources :users do
      collection do
        get :logout
      end
    end
    root to: "users#index"
  end

  namespace :account do
    resources :friend_acts
    resources :refertos do
      get :posts, :on => :collection
      get :members, :on => :collection
    end

    resources :posts do
      get :self, :on => :collection

      resources :postreplies
      # resources :refer_tos
    end

    resource :profile do
      resource :avatar

      get :edit_special_acts, :on => :member
      put :skip_step_3, :on => :collection
    end

    resources :special_acts
    
    resources :lead_generations do
      member do
        put :live, :pause
        get :matched, :top_level_match, :unread_replies, :fetch_replies
      end
    end
  end

  namespace :admin do
    resources :users do
      member do
        put :disable, :active
      end
    end
    resources :level2_admins
    resources :badges
    resources :category_badges
    root to: "users#index"
  end

  resources :contacts do
    collection do
      get 'all'
    end
  end

  resources :messages
  resources :message_thread do
    collection do
      get 'list'
    end
    member do
      post 'ack'
      post 'acknowledgement'
    end
  end

  resource :curruser

  resources :quick_message
  resources :groups do
    member do
      post   'addUser'
      delete 'removeUser'
      get    'toAdd'
    end
    collection do
      get 'simpleidx'
    end
  end
  resources :users do
    collection do
      post :update_score
      post :update_task_note
    end
  end
  get "mailer/mailuser"
  get "mailer/recipientid"
  get "mailer/sendmail"
  get "mailer/mailinbox"
  get "mailer/mailnew"
  get "mailer/mailsettings"
  get "mailer/leadmessage"
  get "mailer/mailnotification"
  
  
  
  root to: 'home#knockout'
end
