class Search
  include ActiveModel::Serializers::JSON
  API_KEY = Rails.application.secrets.tmdb_key
  attr_accessor :id, :title, :release_date, :overview, :poster_path, :poster_url, :poster_thumb, :backdrop_path, :director, :cast

  def attributes
    {'id' => @id,
      'title' => @title,
      'release_date' => @release_date,
      'poster_url' => @poster_url,
      'overview' => @overview,
      'poster_thumb' => @poster_thumb,
      'backdrop_path' => @backdrop_path,
      'cast' => @cast,
      'director' => @director
    }
  end

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
    search = self.new get "movie/#{id}"
    search.get_credits
    search
  end

  def get_credits
    response = Search.get "movie/#{id}/credits"
    @director = response['crew'].map { |c| c['name'] if c['job'] == 'Director'}.compact.first
    @cast = response['cast'][0..3].map{|c| c['name']}.compact
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

  def poster_thumb
    "http://image.tmdb.org/t/p/w154#{@poster_path}"
  end
  

  def self.get url, options={}
    response = RestClient.get("http://api.themoviedb.org/3/" + url, params: options.merge({api_key: API_KEY}))
    JSON.parse(response)
  end
end
