class Movie < ActiveRecord::Base

  attr_accessible :title, :rating, :description, :release_date, :director

  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def self.find_similar(id)
    original_movie = Movie.find(id)
    Movie.find_all_by_director(original_movie.director)
  end
end

