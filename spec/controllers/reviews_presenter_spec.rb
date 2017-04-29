require 'rails_helper'
RSpec.describe 'ReviewsPresenter' do
  context "With review data" do
  	let(:presenter){ReviewsController::ReviewsPresenter.new(stub(fake_reviews))}
    let(:incomplete_presenter){ReviewsController::ReviewsPresenter.new(stub(incomplete_reviews))}
    it "calculates the average" do
      expect(presenter.average_stars).to eq(2.7)
    end
    it "ignores incomplete reviews" do
      expect(incomplete_presenter.average_stars).to eq(4.5)
    end
  end

  def fake_reviews
  	[{:link=>"https://www.yelp.com/biz/dominos-pizza-new-york-9?osq=dominoes", :stars=>2.5, :title=>"Domino’s Pizza"}, {:link=>"https://www.yelp.com/biz/dominos-pizza-new-york-34?osq=dominoes", :stars=>2.5, :title=>"Domino’s Pizza"}, {:link=>"https://www.yelp.com/biz/dominos-pizza-new-york-13?osq=dominoes", :stars=>2.5, :title=>"Domino’s Pizza"}, {:link=>"https://www.yelp.com/biz/dominos-pizza-new-york-35?osq=dominoes", :stars=>2.5, :title=>"Domino’s Pizza"}, {:link=>"https://www.yelp.com/biz/dominos-pizza-new-york-5?osq=dominoes", :stars=>3.0, :title=>"Domino’s Pizza"}, {:link=>"https://www.yelp.com/biz/dominos-pizza-hoboken?osq=dominoes", :stars=>2.5, :title=>"Domino’s Pizza - CLOSED"}, {:link=>"https://www.yelp.com/biz/dominos-pizza-new-york-10?osq=dominoes", :stars=>2.5, :title=>"Domino’s Pizza"}, {:link=>"https://www.yelp.com/biz/dominos-pizza-new-york-6?osq=dominoes", :stars=>2.5, :title=>"Domino’s Pizza"}, {:link=>"https://www.yelp.com/biz/dominos-pizza-nutley?osq=dominoes", :stars=>4.0, :title=>"Domino’s Pizza"}, {:link=>"https://www.yelp.com/biz/dominos-pizza-new-york-11?osq=dominoes", :stars=>2.5, :title=>"Domino’s Pizza"}]
  end
  def stub(reviews)
  	reviews.map {|r| OpenStruct.new(r)}
  end
  def incomplete_reviews
    [{:link=>"https://www.yelp.com/biz/dominos-pizza-new-york-9?osq=dominoes", :stars=>4.5, :title=>"Domino’s Pizza"}, { :stars=>'', :title=>"Domino’s Pizza"}, {}]
  end
end