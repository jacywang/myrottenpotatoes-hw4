require 'spec_helper'

describe MoviesController do
<<<<<<< HEAD
  describe '#index' do
    context 'when params != session' do
      context 'and session[:sort] is nil' do
        before (:each) do
          session[:sort] = nil
          get :index, sort: 'title'
        end

        it 'saves sort order in session' do
          expect(session[:sort]).to eq('title')
        end
      end
    end
  end

  describe '#similar' do

    before(:each) do
      @fake_movie = FactoryGirl.create(:movie)
    end

    context "with at least a mathcing movie" do
      it 'responds with HTTP 200' do
        Movie.stub(:find_similar).and_return(@fake_movie)
        get :similar, id: @fake_movie.id
        expect(response).to be_success
        expect(response.status).to eq(200)
=======

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
>>>>>>> d2e64350221aac51a9c69b02087759386441ef0c
      end
      # it 'responds with HTTP 200' do
      # 	Movie.stub(:find_similar)
      #   get :similar, id: 3
      #   expect(response).to be_success
      #   expect(response.status).to eq(200)
      # end

      it 'renders the similar template' do
<<<<<<< HEAD
        Movie.stub(:find_similar).and_return(@fake_movie)
        get :similar, id: @fake_movie.id
        expect(response).to render_template("similar")
      end

      it 'calls #find_similar' do
        Movie.should_receive(:find_similar).with(@fake_movie.id.to_s)
        get :similar, id: @fake_movie.id
      end

      it 'returns the corresponding movies' do
        @another_fake_movie = FactoryGirl.create(:movie)

        Movie.should_receive(:find_similar).with(@fake_movie.id.to_s).and_return([@fake_movie, @another_fake_movie])
        get :similar, id: @fake_movie.id
        expect(assigns(:movie)).to eq([@fake_movie, @another_fake_movie])
      end
    end

    context "without a matching movie" do
      before(:each) do
        Movie.should_receive(:find_similar).with(@fake_movie.id.to_s).and_return(nil)
        Movie.should_receive(:find).with(@fake_movie.id.to_s).and_return(@fake_movie)
        get :similar, id: @fake_movie.id
      end

      it "redirects to the home page" do
        expect(response).to redirect_to(movies_path)
=======
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
>>>>>>> d2e64350221aac51a9c69b02087759386441ef0c
      end

      it 'shows a flash notice' do
        flash[:notice].should_not be_blank
      end
    end
  end
  
  describe '#show' do
    it 'looks up a movie based on its id' do
      fake_movie = FactoryGirl.create(:movie)
      get :show, id: fake_movie.id
      expect(assigns(:movie)).to eq(fake_movie)
    end
  end

  describe '#new' do
    it 'redirects to new_movie_path' do
      get :new
      expect(response).to render_template(:new)
    end
<<<<<<< HEAD
  end

  describe '#create' do
    it 'redirects to the home page' do
      fake_movie = FactoryGirl.build(:movie)
      get :create, movie: fake_movie
      expect(response).to redirect_to movies_path(fake_movie)
    end
  end

  describe '#edit' do
    it 'should give HTTP 200' do
      fake_movie = FactoryGirl.create(:movie)
      get :edit, id: fake_movie.id
      expect(response.status).to eq(200)
    end
  end

  describe '#update' do
    before (:each) do
      @fake_movie = FactoryGirl.create(:movie)
      Movie.stub(:find).with(@fake_movie.id.to_s).and_return(@fake_movie)
      Movie.stub(:update_attributes!).with(@fake_movie).and_return(true)
      @fake_movie.should_receive(:update)
      get :update, id: @fake_movie.id
    end

    it 'shows a flash notice' do
      flash[:notice].should_not be_blank
    end

    it 'redirects to the home page' do
      expect(response).to redirect_to(movie_path(@fake_movie.id))
    end
  end

  describe '#destroy' do
    before (:each) do
      @fake_movie = FactoryGirl.create(:movie)
      Movie.stub(:find).with(@fake_movie.id.to_s).and_return(@fake_movie)
      @fake_movie.should_receive(:destroy)
      delete :destroy, id: @fake_movie.id
    end

    it 'shows a flash notice' do
      flash[:notice].should_not be_blank
    end

    it 'redirects to the home page' do
      expect(response).to redirect_to(movies_path)
    end
  end
=======
  end  
>>>>>>> d2e64350221aac51a9c69b02087759386441ef0c
end
