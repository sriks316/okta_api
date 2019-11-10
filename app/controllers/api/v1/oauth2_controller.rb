require 'uri'
require 'net/http'
class Api::V1::Oauth2Controller < ApplicationController

	def token
		url = URI("https://dev-254942.okta.com/oauth2/#{params[:authorization_server_id]}/v1/token")
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		request = Net::HTTP::Post.new(url)
		request["Accept"] = 'application/json'
		request["Authorization"] = @_request.env["HTTP_AUTHORIZATION"]

		request.body = "grant_type=password&username=#{params[:username]}&password=#{params[:password]}&scope=openid%20profile%20"

		response = http.request(request)

		Rails.logger.debug("RESPONSE IS #{JSON.parse(response.read_body)}")

		if response.code == 200
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		else
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		end
	end

	def userinfo
		url = URI("https://dev-254942.okta.com/oauth2/#{params[:authorization_server_id]}/v1/userinfo")
		http = Net::HTTP.new(url.host, url.port)
		request = Net::HTTP::Get.new(url)
		http.use_ssl = true
		request["Accept"] = 'application/json'
		request["Authorization"] = @_request.env["HTTP_AUTHORIZATION"]
		response = http.request(request)
		puts response.read_body

		if response.code == 200
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		else
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		end
	end
end