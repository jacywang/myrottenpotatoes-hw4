require 'spec_helper'

describe MoviesController do

  describe "#create" do
    before :each do
      @movie = double 'Movie' 
    end
    it "should create a new movie" do
      post :create, id:1 
    end
    it "should redirect to home page" do
      post :create, id:1
      expect(response).to redirect_to(movies_path)
    end
    it "should give a flash notice" do 
      post :create, id:1
      flash[:notice].should_not be_blank
    end
  end

   describe "#destroy" do
    before :each do
      @movie = mock(Movie, :id => "1", :title => "blah", :director => nil)
      Movie.stub!(:find).with("1").and_return(@movie)
      @movie.should_receive(:destroy)
      delete :destroy, id:1
    end
    it "should redirect to home page" do
      expect(response).to redirect_to(movies_path)
    end
    it "should give a flash notice" do 
      flash[:notice].should_not be_blank
    end
  end

  describe 'GET #similar' do
    context "Happy path" do
      before :each do 
        @fake_movie1 = double :Movie
        @fake_movie2 = double :Movie
        Movie.should_receive(:find_similar).with('3').and_return([@fake_movie1, @fake_movie2])
      end
      # it 'responds with HTTP 200' do
      # 	Movie.stub(:find_similar)
      #   get :similar, id: 3
      #   expect(response).to be_success
      #   expect(response.status).to eq(200)
      # end

      it 'renders the similar template' do
        get :similar, id: 3
        expect(response).to render_template("similar")
      end

      it 'returns the corresponding movies' do
        get :similar, id: 3
        expect(assigns(:movie)).to eq([@fake_movie1, @fake_movie2])
      end
    end

    context "Sad path" do
      it 'should redirect to home page and generate a flash' do
        m=mock(Movie, :title => "Star Wars", :director => nil, :id => "1")
        Movie.stub!(:find).with("1").and_return(m)
        get :similar, :id => "1"
        response.should redirect_to(movies_path)
        flash[:notice].should_not be_blank
      end
    end
  end  
end
