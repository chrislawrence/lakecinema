class Search
  API_KEY = ENV['TMDB_KEY']
  attr_accessor :id, :title, :release_date, :overview, :poster_path, :poster_url

  def self.by_title term
    response = get 'search/movie', {query: term}
    movies = []
    response['results'].each do |result|
      movie = self.new(result)
      movies << {label: "#{movie.title} (#{movie.release_date})", id: movie.id}
    end
    movies.take(10)
  end

  def self.movie_by_id id
    self.new get "movie/#{id}"
  end

  def initialize attributes={}
    attributes.each do |key, value|
      if self.respond_to?(key.to_sym)
        self.instance_variable_set("@#{key}", value)
      end
    end
  end

  def release_date
    Date.parse(@release_date).year if @release_date != ""
  end

  def poster_url
    "http://image.tmdb.org/t/p/original#{@poster_path}"
  end
  

  def self.get url, options={}
    Rails.logger.debug("KEY: #{API_KEY}")
    response = RestClient.get("http://api.themoviedb.org/3/" + url, params: options.merge({api_key: API_KEY}))
    JSON.parse(response)
  end
end
