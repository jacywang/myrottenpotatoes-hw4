require 'spec_helper'

describe MoviesController do
  describe 'GET #similar' do
    let(:fake_movie) { double :Movie }
    before(:each) { Movie.should_receive(:find_similar).with('3').and_return([fake_movie, "Another Movie Title", "A third movie title"]) }

    it 'responds with HTTP 200' do
      get :similar, id: 3
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'renders the similar template' do
      get :similar, id: 3
      expect(response).to render_template("similar")
    end

    it 'shows the director of the movie' do
      get :similar, id: 3
      expect(page).to have_content(@fake_movie.director)
    end
  end  
end
