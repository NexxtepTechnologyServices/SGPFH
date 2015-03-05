Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :notes

  #root to: 'visitors#index'
  root to: 'default#index'
  get '/about' => 'default#about'
  get '/pcf' => 'default#pcf'
  get '/wellness' => 'default#wellness'
  get '/healthcenter' => 'default#healthcenter'

  resources :ref_pysicians

  resources :ref_insurances

  resources :ref_meds
  
  resources :referrals
  post "/update_app_sent/:id" => "referrals#update_app_sent"
  resources :devices

  resources :supplements

  resources :transports

  resources :medications

  resources :awards
  get "/get_award_form/:id" => "awards#get_award_form"
  get "/set_paid/:sub_type/:id" => "awards#set_paid"
  get "/approve/:award/:hash" => "awards#approve_email", :as => :approve_email
  post "/awards/:id/approve_admin" => "awards#approve_admin", :as => :approve_admin
  get "/awards/:award/approve_login/" => "awards#approve_login", :as => :approve_login

  resources :patients
  post "/patientlookup" => "patients#lookup"
<<<<<<< HEAD
  get "/patient/print/:id" => "patients#print", :as => :print_patient

=======
  post "/patients/:id/inlineedit" => "patients#update"
  
>>>>>>> cd8ed94062b87263d0b98b23aab1a90cb525fdbb
  resources :affiliates
  get "/affiliate/approval" => "affiliates#approval", :as => :affiliate_approval
  devise_for :users
  resources :users

  resources :blog_posts

end
