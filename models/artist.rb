require_relative '../db/sql_runner.rb'
require_relative './artist.rb'
require_relative './genre.rb'
require_relative './album.rb'
require_relative './product.rb'
require_relative './sale.rb'
require_relative './transaction.rb'

class Artist
  attr_accessor :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

#Instance methods
  def save
    sql = "INSERT INTO artists
          (name)
          VALUES($1)
          RETURNING *
          "
    values = [@name]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id']
  end

  def albums
    sql = "SELECT FROM albums WHERE id = $1"
    values = [@id]
    results = SqlRunner.run( sql, values )[0]
    return results.map { |album|  Album.new(album) }
  end

  def products
    sql = "SELECT FROM albums WHERE id = $1"
    values = [@id]
    results = SqlRunner.run( sql, values )[0]
    return results.map { |product|  Product.new(product) }
  end

  def update
    sql = "UPDATE artists
          SET (name)
          = ($2)
          WHERE id = $1
          "
    values = [@id,@name]
    SqlRunner.run( sql, values )
  end

  def delete
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end


  # Class methods
  def self.find_by_id(id)
    sql = "SELECT FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )[0]
    return Artist.new(result)
  end

  def self.search_by_name(name)
    sql = "SELECT FROM artists
          WHERE name LIKE %$1%"
    values = [name]
    results = SqlRunner.run( sql, values )
    return results.map { |artist|  Artist.new(artist) }
  end

  def self.all
    sql = "SELECT FROM artists"
    results = SqlRunner.run( sql, values )
    return results.map { |artist|  Artist.new(artist) }
  end

  def self.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run( sql )
  end

end
