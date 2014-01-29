require "sinatra"
require "sinatra/reloader"
require 'pry'
require 'typhoeus'
require 'json'

get '/' do
  erb :index
  
end

post '/result' do
        search_str = params[:movie] #grabs the parameter from the input field in index.erb
        input = Typhoeus.get("www.omdbapi.com", :params => {:s => search_str})
        j_input = JSON.parse(input.body)
        sorted = j_input["Search"] #gets me into the array of hashes by 'Search' (essentially removes Search)
        sorted = sorted.sort_by {|movie| movie["Year"]}.reverse #sort by years, the reversing it

        @display = sorted
        
    erb :results #now go to results.erb
end

get '/poster/:imdb' do |imdb_id|
        # imdb_id = params[:imdb].to_s
  # Make another api call here to get the url of the poster.
  input = Typhoeus.get("www.omdbapi.com", :params => {:i => imdb_id})
  @j_input = JSON.parse(input.body)


erb :poster        




end