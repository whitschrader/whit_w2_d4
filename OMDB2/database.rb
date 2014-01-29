require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'pg'



# List all movies
get '/poster/:imdb' do
  c = PGconn.new(:host => "localhost", :dbname => "testdb")
  c.exec_params("INSERT INTO movies (imdb) VALUES($1);", [@imdb])
  c.close
  erb :movies
end


# A method that can create the table for us 
def create_movies_table
  c = PGconn.new(:host => "localhost", :dbname => "testdb")
  c.exec %q{
  CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    imdb TEXT
  );
  }
  c.close
end

# A method that will get rid of the table
def drop_movies_table
  c = PGconn.new(:host => "localhost", :dbname => "testdb")
  c.exec "DROP TABLE products;"
  c.close
end