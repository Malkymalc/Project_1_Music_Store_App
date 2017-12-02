require 'sinatra'
require 'sinatra/contrib/all'
require 'pry-byebug'
require_relative '../models/artist.rb'
require_relative '../models/album.rb'
require_relative '../models/product.rb'
require_relative '../models/transaction.rb'
require_relative '../models/sale.rb'
#require_relative '../models/staff.rb'
#require_relative '../models/shift.rb'

get '/stock' do
  redirect to '/stock/grid'
end

# Search routes
get '/stock/search' do
  erb ( :"stock/search" )
end

post '/stock/results' do
  erb ( :"stock/results" )
end

# Add routes
get '/stock/add' do
  erb ( :"stock/add" )
end

post '/stock/confirm' do
  @confirm = Product.bulk_add(params)
  erb ( :"stock/confirm" )
end

# Search by specified paramater
get '/stock/:display/artist/:artist' do
  artist = params[:artist]
  @products = Product.artist(artist)
  @display = params[:display]
  #binding.pry
  erb ( :"stock/products" )
end

get '/stock/:display/genre/:genre' do
  @products = Product.genre(params[:genre])
  @display = params[:display]
  #binding.pry
  erb ( :"stock/products" )
end

# keep this at the bottom
get '/stock/:display' do
  @display = params[:display]
  #binding.pry
  @products = Product.all()
  erb ( :"stock/products" )
end
