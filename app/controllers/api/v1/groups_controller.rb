require 'uri'
require 'net/http'

class Api::V1::GroupsController < ApplicationController

	def add_user
		url = URI("#{API_URL}/groups/#{params[:group_id]}/users/#{params[:user_id]}")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		request = Net::HTTP::Put.new(url)
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

	def admin_group
		url = URI("#{API_URL}/groups?q=admin")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		request = Net::HTTP::Get.new(url)
		request["Content-Type"] = 'application/json'
		request["Accept"] = 'application/json'
		request["Authorization"] = "#{API_KEY}"

		response = http.request(request)

		if response.code == 200
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		else
			render json: { message: JSON.parse(response.read_body)}, status: response.code
		end
	end
end