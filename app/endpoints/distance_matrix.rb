class DistanceMatrix
	KEY = 'AIzaSyAqlBXjNwKCcX_evq51V3k62Ldx7aPByAk'
	BASE_URL = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&transit_mode=train"

	def self.get_distance(apt_1, apt_2)
		origins = apt_1.searchable_address
		destinations = apt_2.searchable_address
		response = JSON.parse(RestClient.get("#{BASE_URL}&origins=#{origins}&destinations=#{destinations}&key=#{KEY}"))
		return response["error_message"] if response["error_message"].present? 
		response['rows'][0]['elements'][0]['duration']['value'] rescue nil
	end

end