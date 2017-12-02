require 'sinatra'
require 'sinatra/contrib/all'
require_relative '../models/auth.rb'
require_relative '../models/customer.rb'
require_relative '../models/staff.rb'


get '/log_in' do
  erb ( :"auth/log_in" )
end

# Is this the right syntax for if's?
post '/go' do
  user = Auth.find(params)
  if user.customer
    @customer = user
    erb ( :"customer/customer" )
  end
  if user.staff
    @staff = user
    erb ( :"staff/staff" )
  end
  erb ( :"auth/try_again" )
end


get '/reset' do
  erb ( :"auth/reset" )
end


post '/conf' do
  Auth.reset(params)
  erb ( :"auth/conf" )
end
