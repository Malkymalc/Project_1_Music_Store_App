require 'sinatra'
require 'sinatra/contrib/all'
require_relative '../models/artist.rb'
require_relative '../models/album.rb'
require_relative '../models/product.rb'
require_relative '../models/transaction.rb'
require_relative '../models/sale.rb'
#require_relative '../models/staff.rb'
#require_relative '../models/shift.rb'

get '/people' do
  erb ( :"people/people" )
end
