require 'rails_helper'
RSpec.describe YelpSearch do
  context "Finds review data" do

    it "searches a url for specific reviews " do
      reviews = YelpSearch.new('https://www.yelp.com/biz/ginos-pizza-new-york', limit: 5).specific_reviews
      expect(reviews.count).to eq(5)
    end
  end

end