require 'sinatra'
require 'sinatra/contrib/all'
# require_relative './controllers/auth.rb'
require_relative './controllers/home.rb'
require_relative './controllers/stock.rb'
require_relative './controllers/sales.rb'
require_relative './controllers/people.rb'
require_relative './controllers/stats.rb'

#@nav = Nav.new()

get '/' do
#  @nav.go(params)
  erb( :index )
end

# Footer views
get '/us' do
#  @nav.go(params)
  erb ( :"footer/homepage")
end

get '/about_app' do
#  @nav.go(params)
  erb ( :"footer/about_app" )
end

get '/contact' do
#  @nav.go(params)
  erb ( :"footer/contact" )
end

get '/terms' do
#  @nav.go(params)
  erb ( :"footer/ts_and_cs" )
end

get '/settings' do
#  @nav.go(params)
  erb ( :"footer/settings" )
end
