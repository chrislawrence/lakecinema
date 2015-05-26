class PosterDownloader
  @queue = :posters
  def self.perform movie_id
    Rails.logger.debug("Poster downloader working...")
    Movie.find(movie_id).download_images
  end
end
