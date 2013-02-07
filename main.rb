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
  @data = view_movie(@search)
  #redirect to "/movies/#{@data['Title']}/#{@data['Poster']}"
  erb :movie_data
end

get '/faq' do
  erb :faq
end

get '/about' do
  erb :about
end

get '/movies/:title/:Poster' do
  @data = {}
  @data['Title'] = params['title']
  @data['Poster'] = params['poster']

  erb :movie_data
end



def view_movie(search)
  begin
    JSON(HTTParty.get("http://www.omdbapi.com/?t=#{search}").body)
  rescue
    "error: could not connect"
  end
end