require_relative '../db/sql_runner.rb'
require_relative './artist.rb'
require_relative './genre.rb'
require_relative './album.rb'
require_relative './product.rb'
require_relative './sale.rb'
require_relative './transaction.rb'

class Album
  attr_accessor :id, :artist_id, :title, :length, :genre_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
    @title = options['title']
    @length = options['length']
    @genre_id = options['genre_id'].to_i
  end

#Instance methods
  def save
    sql = "INSERT INTO albums
          (artist_id, title, length, genre_id)
          VALUES($1, $2, $3, $4)
          RETURNING *
          "
    values = [@artist_id, @title, @length, @genre_id]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id']
  end

  def products
    sql = "SELECT FROM products
          WHERE products.type = $1
          INNER JOIN albums ON products.album_id = albums.id
          WHERE albums.id = $2"
    values = ['album',@id]
    results = SqlRunner.run( sql, values )[0]
    return results.map { |sales|  Sale.new(sale) }
  end

  def sales
    sql = "SELECT FROM sales
          INNER JOIN products ON sales.product_id = products.id
          WHERE products.type = $1
          INNER JOIN albums ON products.album_id = albums.id
          WHERE album.id = $2"
    values = ['albums',@id]
    results = SqlRunner.run( sql, values )[0]
    return results.map { |sales|  Sale.new(sale) }
  end

  def update
    sql = "UPDATE albums
          SET (artist_id, title, length, genre_id)
          = ($1, $2, $3, $4)
          WHERE id = $5
          "
    values = [@artist_id,@title, @length, @genre_id, @id]
    SqlRunner.run( sql, values )
  end

  def delete
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end


  # Class methods
  def self.find_by_id(id)
    sql = "SELECT FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )[0]
    return Album.new(result)
  end

  def self.search_by_genre(genre)
    sql = "SELECT FROM albums
          INNER JOIN genres ON albums.genre_id = genres.id
          WHERE genres.genre LIKE %$1%"
    values = [genre]
    results = SqlRunner.run( sql, values )
    return results.map { |album|  Album.new(album) }
  end

  def self.search_by_artist(artist)
    sql = "SELECT FROM albums
          INNER JOIN artists ON albums.artist_id = artists.id
          WHERE artists.name LIKE %$1%"
    values = [artist]
    results = SqlRunner.run( sql, values )
    return results.map { |album|  Album.new(album) }
  end

  def self.all
    sql = "SELECT FROM albums"
    results = SqlRunner.run( sql, values )
    return results.map { |albums|  Album.new(album) }
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run( sql )
  end

end
