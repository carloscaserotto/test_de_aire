Rails.application.routes.draw do
  root to: "home#index"
  resources :patients, :tdas, :doctors
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  get 'list/doctors', to: "doctors#indexJson"
  post 'list/doctors/:name', to: "doctors#addDoctorJson"
  get 'list/doctors/:name', to: "doctors#showJson"
  get 'inform/:id', to: "inform#create"
  
  get 'show_table', to: "inform#show_table"
  post 'show_table', to: "inform#show_table"
  
  get 'show_chart', to: "inform#show_chart"
  post 'show_chart', to: "inform#show_chart"

  #get 'chart', to: "inform#show_table"
  post 'chart', to: "inform#show_chart"

  #post 'pdf/:id', to: 'users#pdf'
  post 'inform/pdf', to: 'inform#pdf'
  
end
