Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/all', :to => 'pings#all'
  get '/all/:date', :to => 'pings#allbydate'
  get '/all/:from/:to', :to => 'pings#allfromto'
  get '/:device_id/:date', :to => 'pings#bydate'
  get '/:device_id/:from/:to', :to => 'pings#fromto'
  get '/devices', :to => 'devices#index'
  post '/:device_id/:date', :to => 'pings#create'
  post '/clear_data', :to => 'pings#clear'
end
