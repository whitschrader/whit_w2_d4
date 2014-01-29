require "sinatra"
require "sinatra/reloader"
require 'pry'

# you can get this to work by calling the index.html file which holds "hello world"
# get "/" do
# 	send_file "views/index.html"
# end
MY_DB = []

get "/" do
	# @greeting = params[:greeting]

	redirect "/home"
end

# the CREATE METHOD/ROUTE for an Animal
get "/home" do
	@animals = MY_DB

  erb :index
end

post "/add" do	
  # params is: {"animal"=>{"species"=>"Cat", "description"=>"super cute cat"}}
	animal = params[:animal]
  # animal is {"species"=>"Cat", "description"=>"super cute cat"}
  
  MY_DB << animal
	id = MY_DB.length - 1

	redirect "/animals/#{id}"  #now you can see the animals by searching animal/ID#

end

# the SHOW METHOD/ROUTE for an Animal

get "/animals/:id" do 
	id = params[:id].to_i
	@animal = MY_DB[id]

	erb :show 
end
