class PosterDownloader
  @queue = :posters

  def self.perform movie_id
    Movie.find(movie_id).download_images
  end
end
