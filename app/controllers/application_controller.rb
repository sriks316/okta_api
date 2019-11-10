class ApplicationController < ActionController::API
	API_URL = Rails.application.config_for(:config)["api_url"]
  API_KEY = Rails.application.config_for(:config)["api_key"]
end
