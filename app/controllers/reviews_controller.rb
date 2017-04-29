class ReviewsController < ApplicationController
  def index
  	
  end

  def narrow_down_suggestions
    @results_count = params[:results_count]
    @suggestions = YelpSearch.new(params[:query], limit: @results_count).search_options
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end

  def get_reviews
    @results_count = params[:results_count]
    @reviews = YelpSearch.new(params[:url], limit: @results_count).specific_reviews
    @reviews_presenter = ReviewsPresenter.new(@reviews)
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end


end
