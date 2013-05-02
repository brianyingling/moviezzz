require 'rack'
require 'pry'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'httparty'
require 'pg'

# get '/' do
#   erb :movie_data
# end
class App < Sinatra::Base

  get '/' do
    if params['search'].present?
      @search = params['search'].gsub(' ','+')
      @data = view_movie(@search)
      sql = "insert into movies (title, poster, year, rated, released, runtime, genre, director, writers, actors, plot) values (\'#{@data['Title']}\',\'#{@data['Poster']}\',\'#{@data['Year']}\',\'#{@data['Rated']}\',\'#{@data['Released']}\',\'#{@data['Runtime']}\',\'#{@data['Genre']}\',\'#{@data['Director']}\',\'#{@data['Writer']}\',\'#{@data['Actors']}\',\'#{@data['Plot'].gsub("'","")}\')"
      conn = PG.connect(:dbname=> 'movie_app', :host=>'localhost')
      conn.exec(sql)
      conn.close
    end
    erb :movie_data
  end

  get '/faq' do
    erb :faq
  end

  get '/about' do
    erb :about
  end

  get '/movies' do
    sql = "select poster from movies"
    conn = PG.connect(:dbname=>'movie_app',:host=>'localhost')
    binding.pry
    @rows = conn.exec(sql)
    conn.close

   erb :posters
  end



  def view_movie(search)
    begin
      JSON(HTTParty.get("http://www.omdbapi.com/?t=#{search}").body)
    rescue
      "error: could not connect"
    end
  end
end