require_relative '../db/sql_runner.rb'
require_relative './artist.rb'
require_relative './genre.rb'
require_relative './album.rb'
require_relative './product.rb'
require_relative './sale.rb'
require_relative './transaction.rb'

class Product
  attr_accessor :id, :product_id, :url, :alt, :type, :stock, :stock_level, :buy, :sell, :markup

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @product_id = options['product_id'].to_i
    @url = options['url']
    @alt = options['alt']
    @type = options['type']
    @stock = options['stock'].to_i
    @stock_level = Product.stock_level(@stock)
    @buy = options['buy'].to_f
    @sell = options['sell'].to_f
    @markup = (( (@sell - @buy) / @buy ) * 100).to_i
  end

  def self.stock_level(stock)
  return "Out of Stock" if stock < 1
  return "Low" if stock <= 3
  return "Med" if stock <= 6
  return  "High" if stock > 6
  end

#Instance methods
  def save
    sql = "INSERT INTO products
          (product_id, url ,alt ,type ,stock ,buy ,sell)
          VALUES($1, $2, $3, $4, $5, $6, $7)
          RETURNING *
          "
    values = [@product_id, @url, @alt, @type, @stock, @buy, @sell]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id'].to_i
  end

  def title
    sql = "SELECT albums.title
          FROM albums
          INNER JOIN products ON albums.id = products.product_id
          WHERE products.id = $1
          "
    values = [@id]
    result = SqlRunner.run( sql, values )
    return result[0]["title"]
  end

  def artist
    sql = "SELECT artists.name
          FROM artists
          INNER JOIN albums ON artists.id = albums.artist_id
          INNER JOIN products ON albums.id = products.product_id
          WHERE products.id = $1
          "
    values = [@id]
    result = SqlRunner.run( sql, values )
    return result[0]["name"]
  end

  def genre
    sql = "SELECT genres.genre
          FROM genres
          INNER JOIN albums ON genres.id = albums.genre_id
          INNER JOIN products ON albums.id = products.product_id
          WHERE products.id = $1
          "
    values = [@id]
    result = SqlRunner.run( sql, values )
    return result[0]["genre"]
  end

  def update
    sql = "UPDATE products
          SET (product_id, url ,alt ,type ,stock ,buy ,sell)
          = ($1, $2, $3, $4, $5, $6, $7)
          WHERE id = $1
          "
    values = [@id,@product_id, @url, @alt, @type, @stock, @buy, @sell]
    SqlRunner.run( sql, values )
  end

  def delete
    sql = "DELETE FROM products WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  # Class methods
  def self.bulk_add(form)
    artist = Artist.new(form) if form.has_key?("add_artist")
    artist.save()
    artist = form['artist'] if !form.has_key?("add_artist")
    genre = Genre.new(form) if form.has_key("add_genre")
    genre.save()
    genre = Genre.find_by_id(form['genre']) if !form.has_key?("add_genre")

    if form['add_album']
    album_obj = {
      'artist_id'=> artist.id,
      'title'=> form['title'],
      'length'=> form['length'],
      'genre_id'=> genre.id
    }
    album = Album.new(form)
    album.save()

    if !form['add_album']
    album = Album.find_by_id(form['album'])

    if form.has_key?(['add_product'])
    product_obj = {
      'product_id'=> album.id,
      'url' => form['url'],
      'alt' => form['alt'],
      'type' => form['type'],
      'stock'=> form['stock'],
      'buy'=> form['buy'],
      'sell'=> form['sell']
    }
    product = Product.new(product_obj)
    product.save()

    confirm = {}
    confirm[:genre] = genre if form.has_key?('new_genre')
    confirm[:artist] = artist if form.has_key?('new_artist')
    confirm[:album] = album if form.has_key?('new_album')
    confirm[:product] = product if form.has_key?('new_product')
    return confirm
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM products WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )[0]
    return Product.new(result)
  end

  def self.artist(name)
    sql = "SELECT * FROM products
          INNER JOIN albums ON products.product_id = albums.id
          INNER JOIN artists ON albums.artist_id = artists.id
          WHERE artists.name = $1
          "
    values = [name]
    results = SqlRunner.run( sql, values )
    return results.map { |product|  Product.new(product) }
  end

  def self.genre(genre)
    sql = "SELECT * FROM products
          INNER JOIN albums ON products.product_id = albums.id
          INNER JOIN genres ON albums.genre_id = genres.id
          WHERE genres.genre= $1
          "
    values = [genre]
    results = SqlRunner.run( sql, values )
    return results.map { |product|  Product.new(product) }
  end

  def self.filter_by_product_type(type)
    sql = "SELECT * FROM products
     WHERE type = $1"
    values = [type]
    result = SqlRunner.run( sql, values )
    return result.map { |product|  Product.new(product) }
  end

  def self.all
    sql = "SELECT * FROM products"
    results = SqlRunner.run( sql )
    return results.map { |product|  Product.new(product) }
  end

  def self.delete_all
    sql = "DELETE FROM products"
    SqlRunner.run( sql )
  end
end
