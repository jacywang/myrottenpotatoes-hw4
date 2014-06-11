require 'spec_helper'

describe MoviesController do
  describe 'GET #similar' do

    it 'responds with HTTP 200' do
    	Movie.stub(:find_similar)
      get :similar, id: 3
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'renders the similar template' do
    	Movie.stub(:find_similar)
      get :similar, id: 3
      expect(response).to render_template("similar")
    end

    it 'calls #find_similar' do
      Movie.should_receive(:find_similar).with("3")
      get :similar, id: 3
    end

    it 'returns the corresponding movies' do
    	fake_movie1 = double :Movie
    	fake_movie2 = double :Movie
    	Movie.should_receive(:find_similar).with('3').and_return([fake_movie1, fake_movie2])
      get :similar, id: 3
      expect(assigns(:movie)).to eq([fake_movie1, fake_movie2])
    end
  end  
end
