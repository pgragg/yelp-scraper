class YelpSearch
	require 'ostruct'
	
	BASE_URL = "https://www.yelp.com/search"
	OUTPUT_BASE_URL = "https://www.yelp.com"

	def initialize(query, opts={})
		@search_results = []
		@query = query
		@url = build_url
		@agent = build_agent
		@limit = opts[:limit].to_i || 10 
	end

	def search_options
		@agent.get(@url) do |page|
			page.parser.css("li.regular-search-result").each do |page_result|
				next if @search_results.count >= @limit 
				link  =  get_link(page_result.search('.biz-name').first.attributes['href'].value)
				stars =  get_stars(page_result.search('.i-stars').first.attributes['title'].value)
				title =  page_result.search('.indexed-biz-name span').map(&:children).flatten.map(&:content).uniq.join('')
				@search_results << OpenStruct.new({link: link, stars: stars, title: title})
			end
		end
		@search_results.sort_by {|review| -review.stars}
	end

	def specific_reviews
		@agent.get(@query) do |page|
			page.parser.css(".review")[1..-1].each do |page_result|
				next if @search_results.count >= @limit 
				stars =  get_stars(page_result.search('.i-stars').first.attributes['title'].value)
				review =  page_result.search('.review-content p').first.content
				@search_results << OpenStruct.new({stars: stars, content: review})
			end
		end
		@search_results
	end

	private
	def get_link(str)
		"#{OUTPUT_BASE_URL}#{str}"
	end
	
	def get_stars(str)
		float_match = str.scan(/(\d+[.,]\d+)/).flatten.first
	  float = float_match.tr(',', '.').to_f
	  ("%.2f" % float).to_f
	end

	def build_url
		params = "?find_desc=#{CGI.escape(@query)}&find_loc=New+York%2C+NY&ns=1"
		url = "#{BASE_URL}#{params}"
	end

	def build_agent
		Mechanize.new do |agent|
		  agent.user_agent_alias = 'Mac Safari'
		end
	end

end