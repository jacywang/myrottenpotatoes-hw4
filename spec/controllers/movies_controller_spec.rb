require 'spec_helper'

describe MoviesController do
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
      end

      it 'renders the similar template' do
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
end
