Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	namespace :api, defaults: {format: 'json'} do
	  namespace :v1 do
	  	resources :users do
	    	post '/:user_id/factors/:factor_id/verify', to: 'users#verify_user_factor'
	    	post  '/lifecycle/deactivate', to: 'users#deactivate'
	    	get  '/groups', to: 'users#groups'
	    end
	    resource :authn do
	    	post '/factors/:factor_id/verify', to: 'authn#factors'
	    end
	    resource :groups do
	    	put '/:group_id/users/:user_id/', to: 'groups#add_user'
	    	get '/admin_group', to: 'groups#admin_group'
	    end

	    resource :oauth2 do
	    	post '/:authorization_server_id/token', to: 'oauth2#token'
	    	get '/:authorization_server_id/userinfo', to: 'oauth2#userinfo' 
	    	post '/:authorization_server_id/secure', to: 'oauth2#secure' 
	    end
	  end
	end
end
