require 'uri'
require 'net/http'

class Api::V1::UsersController < ApplicationController
	
	def create
		url = URI("#{API_URL}/users?activate=true")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		request = Net::HTTP::Post.new(url)
		request["Accept"] = 'application/json'
		request["Content-Type"] = 'application/json'
		request["Authorization"] = 'SSWS 00PQwmsXHySRSglpeFyRWowoBSZnMA9muBGqqpvxDJ'
		#request.body = params[:user].to_json
		request.body = "{\n  \"profile\": {\n\"firstName\": \"#{params[:firstName]}\",\n\"lastName\": \"#{params[:lastName]}\",\n    \"email\": \"#{params[:email]}\",\n    \"login\": \"#{params[:email]}\"\n  },\n  \"credentials\": {\n    \"password\" : { \"value\": \"#{params[:password]}\" }\n  }\n}"

		response = http.request(request)

		Rails.logger.debug("RESPONSE IS #{JSON.parse(response.read_body)}")

		if response.code == 200
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		else
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		end

	end

	def index
		url = URI("#{API_URL}/users?filter=status%20eq%20%22ACTIVE%22&limit=50")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		request = Net::HTTP::Get.new(url)
		request["Accept"] = 'application/json'
		request["Content-Type"] = 'application/json'
		request["Authorization"] = "#{API_KEY}"

		response = http.request(request)

		Rails.logger.debug("RESPONSE IS #{JSON.parse(response.read_body)}")

		if response.code == 200
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		else
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		end
	end

	def update
		url = URI("#{API_URL}/users/#{params[:id]}")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		request = Net::HTTP::Post.new(url)
		request["Accept"] = 'application/json'
		request["Content-Type"] = 'application/json'
		request["Authorization"] = "#{API_KEY}"
		#request.body = params[:user].to_json

		response = http.request(request)

		if response.code == 200
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		else
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		end
	end

	def show

		url = URI("#{API_URL}/users/#{params[:id]}")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		request = Net::HTTP::Get.new(url)
		request["Accept"] = 'application/json'
		request["Content-Type"] = 'application/json'
		request["Authorization"] = "#{API_KEY}"

		response = http.request(request)

		if response.code == 200
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		else
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		end
	end

	def groups
		url = URI("#{API_URL}/users/#{params[:user_id]}/groups")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		request = Net::HTTP::Get.new(url)
		request["Accept"] = 'application/json'
		request["Content-Type"] = 'application/json'
		request["Authorization"] = "#{API_KEY}"

		response = http.request(request)

		if response.code == 200
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		else
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		end
	end

	def deactivate

		url = URI("#{API_URL}/users/#{params[:user_id]}/lifecycle/deactivate")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		request = Net::HTTP::Post.new(url)
		request["Content-Type"] = 'application/json'
		request["Accept"] = 'application/json'
		request["Authorization"] = "#{API_KEY}"

		response = http.request(request)

		Rails.logger.debug("RESPONSE IS #{JSON.parse(response.read_body)}")

		if response.code == 200
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		else
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		end
	end

	private

	def user_params
    #params.require(:authn).permit(:passCode, :stateToken)
  end

end