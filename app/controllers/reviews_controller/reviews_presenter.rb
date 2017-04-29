class ReviewsController::ReviewsPresenter

	def initialize(reviews)
		@reviews = reviews 
	end

	def average_stars
		stars = @reviews.map(&:stars).compact.keep_if {|r| r.to_f == r}
		stars.inject{ |sum, el| sum + el.to_f } / stars.count
	end

end