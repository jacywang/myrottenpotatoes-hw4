require 'spec_helper'

describe Movie do
  describe '#find_similar' do
    before(:each) do
      @movie = FactoryGirl.create(:movie, title: 'Jacy and Pierre learn Rails', director: 'Jacy')
    end

    it 'finds the director of the movie' do
      expect(@movie.director).to eq(Movie.find_similar(@movie.id)[0].director)
    end

    it 'returns the movie list with the same director' do
      movie1 = FactoryGirl.create(:movie, title: 'Jacy wants to eat an apple', director: 'Jacy')
      movie2 = FactoryGirl.create(:movie, title: 'Pierre needs an awesome job', director: 'Pierre')

      expect(Movie.find_similar(@movie.id)).to eq([@movie, movie1])
    end
  end
end
  