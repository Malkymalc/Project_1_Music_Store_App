require_relative '../models/artist.rb'
require_relative '../models/genre.rb'
require_relative '../models/album.rb'
require_relative '../models/product.rb'
# require_relative '../models/transaction.rb'
# require_relative '../models/sale.rb'
require 'pry-byebug'

Sale.delete_all()
Transaction.delete_all()
Product.delete_all()
Album.delete_all()
Genre.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name'=>'Guns and Roses'})
artist1.save()
artist2 = Artist.new({'name'=>'Bob Dylan'})
artist2.save()
artist3 = Artist.new({'name'=>'The Doors'})
artist3.save()
artist4 = Artist.new({'name'=>'Jimi Hendrix'})
artist4.save()
artist5 = Artist.new({'name'=>'Jackson Browne'})
artist5.save()



genre1 = Genre.new('genre'=>'Hard Rock')
genre1.save()
genre2 = Genre.new('genre'=>'Folk')
genre2.save()
genre3 = Genre.new('genre'=>'Rock')
genre3.save()
genre4 = Genre.new('genre'=>'Singer-songwriter')
genre4.save()



album1 = Album.new({'artist_id'=>2, 'title'=>'Time Out of Mind', 'length'=>'56 mins 34 secs', 'genre_id'=>2})
album1.save()
album2 = Album.new({'artist_id'=>3, 'title'=>'L.A. Woman', 'length'=>'1 hour 02 mins 05 secs', 'genre_id'=>3})
album2.save()
album3 = Album.new({'artist_id'=>1, 'title'=>'Appetite for Destruction', 'length'=>'50 minutes 31 secs', 'genre_id'=>1})
album3.save()
album4 = Album.new({'artist_id'=>4, 'title'=>'Axis: Bold as Love', 'length'=>'49 mins 37 secs', 'genre_id'=>3})
album4.save()
album5 = Album.new({'artist_id'=>5, 'title'=>'Late for the Sky', 'length'=>'53 mins 32 secs', 'genre_id'=>4})
album5.save()

# binding.pry
# nil

product1 = Product.new('product_id'=>'1', 'url' => nil, 'alt' => 'A picture', 'type' => 'album' ,'stock'=>7, 'buy'=>11.50, 'sell'=>13.00)
product1.save()

product2 = Product.new('product_id'=>'2', 'url' => nil, 'alt' => 'A picture', 'type' => 'album' ,'stock'=>5, 'buy'=>11.00, 'sell'=>15.00)
product2.save()

product3 = Product.new('product_id'=>'3', 'url' => nil, 'alt' => 'A picture', 'type' => 'album' ,'stock'=>3, 'buy'=>10.00, 'sell'=>12.75)
product3.save()

product4 = Product.new('product_id'=>'4', 'url' => nil, 'alt' => 'A picture', 'type' => 'album' ,'stock'=>12, 'buy'=>9.50, 'sell'=>15.00)
product4.save()

product5 = Product.new('product_id'=>'5', 'url' => nil, 'alt' => 'A picture', 'type' =>'album' ,'stock'=>26, 'buy'=>9.50, 'sell'=>12.50)
product5.save()


#transaction1 = Transaction.new({'amount'=>''})



#binding.pry
#nil
#
# customer1 = Customer.new({'email'=>'alan@alan.com', 'password'=>'abacus', 'first_name'=>'alan', 'last_name' => 'smith', 'customer' => true, 'address' => '1 Hobo Way', 'phone' => '0111'})
# customer1.save()
#
# customer2 = Customer.new({'email'=>'bob@bob.com','password'=>'boo','first_name'=>'bob','last_name' => 'roberts', 'customer' => true, 'address' => '2 Wolf Way','phone' => '0121')
# customer2.save()
#
# customer3 = Customer.new({'email'=>'chris@cornell.com','password'=>'church','first_name'=>'alan','last_name' => 'smith', 'customer' => true, 'address' => '3 Wolf Crescent','phone' => '0131'})
# customer3.save()
#
# customer4 = Customer.new({'email'=>'dave@davis.com','password'=>'door','first_name'=>'dave','last_name' => 'davis', 'customer' => true, 'address' => '4 Foxtrot Road','phone' => '0141'})
# customer4.save()
#
# customer5 = Customer.new({'email'=>'ellen@echo.com','password'=>'ear','first_name'=>'elen','last_name' => 'echo', 'customer' => true, 'address' => '5 Cat Street','phone' => '0151'})
# customer5.save()
#
# customer6 = Customer.new({'email'=>'fred@freeman.com','password'=>'fone','first_name'=>'fred','last_name' => 'freeman', 'customer' => true, 'address' => '6 Fox Street','phone' => '0161'})
# customer6.save()
#
# customer7 = Customer.new({'email'=>'gail@gobmore.com','password'=>'good','first_name'=>'gail','last_name' => 'gobmore', 'customer' => true, 'address' => '7 Glimmer Crossroads','phone' => '0171'})
# customer7.save()
#
# staff1 = Staff.new({'email'=>'harry@hobo.com','password'=>'hello','first_name'=>'hary','last_name' => 'hobo', 'staff' => true})
# staff1.save()
#
# staff2 = Staff.new({'email'=>'ian@iguana.com','password'=>'izzy_stradlin','first_name'=>'ian','last_name' => 'iguana', 'staff' => true})
# staff2.save()
#
# staff3 = Staff.new({'email'=>'justinth@jardin.com','password'=>'jello','first_name'=>'justinth','last_name' => 'jardin', 'staff' => true})
# staff3.save()
#
# staff4 = Staff.new({'email'=>'karol@kaye.com','password'=>'get_some','first_name'=>'karol','last_name' => 'kaye', 'staff' => true})
# staff4.save()
#
# staff5 = Staff.new({'email'=>'liam@lobo.com','password'=>'leet','first_name'=>'liam','last_name' => 'lobo', 'staff' => true})
# staff5.save()
