require_relative '../db/sql_runner.rb'
require_relative './artist.rb'
require_relative './genre.rb'
require_relative './album.rb'
require_relative './product.rb'
require_relative './sale.rb'
require_relative './transaction.rb'

class Genre
  attr_accessor :id, :genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @genre = options['genre']
  end

#Instance methods
  def save
    sql = "INSERT INTO genres
          (genre)
          VALUES($1)
          RETURNING *
          "
    values = [@genre]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id']
  end

  def albums
    sql = "SELECT FROM albums WHERE genre_id = $1"
    values = [@id]
    results = SqlRunner.run( sql, values )[0]
    return results.map { |album|  Album.new(album) }
  end

  def products
    sql = "SELECT FROM products
          WHERE products.type = $1
          INNER JOIN albums ON products.product_id = albums.id
          WHERE albums.genre_id = $2"
    values = ["album", @id]
    results = SqlRunner.run( sql, values )[0]
    return results.map { |product|  Product.new(product) }
  end

  def update
    sql = "UPDATE genres
          SET (genre)
          = ($2)
          WHERE id = $1
          "
    values = [@id,@genre]
    SqlRunner.run( sql, values )
  end

  def delete
    sql = "DELETE FROM genres WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end


  # Class methods
  def self.all
    sql = "SELECT FROM genres"
    results = SqlRunner.run( sql )
    return results.map { |genre|  Genre.new(order) }
  end

  def self.delete_all
    sql = "DELETE FROM genres"
    SqlRunner.run( sql )
  end

end
