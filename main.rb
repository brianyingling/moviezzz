require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'JSON'
require 'httparty'

# get '/' do
#   erb :movie_data
# end


get '/' do
  if params['search'].present?
    @search = params['search'].gsub(' ','+')
  end
  @data = view_movie(@search) || nil
  erb :movie_data
end

get '/faq' do
  erb :faq
end

get '/about' do
  erb :about
end

def view_movie(search)
  movie = HTTParty.get("http://www.omdbapi.com/?t=#{search}")
  JSON(movie.body)
end