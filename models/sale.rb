require_relative '../db/sql_runner.rb'
require_relative './artist.rb'
require_relative './genre.rb'
require_relative './album.rb'
require_relative './product.rb'
require_relative './sale.rb'
require_relative './transaction.rb'

class Sale
  attr_accessor :id, :amount, :date_time, :refund

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
    @date_time = options['date_time'] if options['date_time']
    @refund = options['refund']
  end

#Instance methods
  def save
    sql = "INSERT INTO transactions
          (amount,date_time)
          VALUES($1,$2)
          RETURNING *
          "
    values = [@amount,Time.now.utc]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id']
    @date_time = result[0]['date_time']
  end

  def sales
    sql = "SELECT FROM sales WHERE id = $1"
    values = [@amount]
    result = SqlRunner.run( sql, values )[0]
    return Customer.new(result)
  end

  def update
    sql = "UPDATE transactions
          SET (amount, date_time)
          = ($2,S3)
          WHERE id = $1
          "
    values = [@id,@amount,@date_time]
    SqlRunner.run( sql, values )
  end

  def delete
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  # Class methods
  def self.find_by_id(id)
    sql = "SELECT FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )[0]
    return Transaction.new(result)
  end

  def self.filter_by_amount(min,max)
    sql = "SELECT FROM transactions
     WHERE amount = $1"
    values = [min,max]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.filter_by_date(start, nd)
    sql = "SELECT FROM transactions
          WHERE date_time = $1"
    values = [start,nd]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.filter_by_refund(refund_bool)
    sql = "SELECT FROM transactions
          WHERE refund = $1"
    values = [refund_bool]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.all
    sql = "SELECT FROM transactions"
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end

end
require_relative '../db/sql_runner.rb'

class Transaction
  attr_accessor :id, :amount, :date_time, :refund

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
    @date_time = options['date_time'] if options['date_time']
    @refund = options['refund']
  end

#Instance methods
  def save
    sql = "INSERT INTO transactions
          (amount,date_time)
          VALUES($1,$2)
          RETURNING *
          "
    values = [@amount,Time.now.utc]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id']
    @date_time = result[0]['date_time']
  end

  def sales
    sql = "SELECT FROM sales WHERE id = $1"
    values = [@amount]
    result = SqlRunner.run( sql, values )[0]
    return Customer.new(result)
  end

  def update
    sql = "UPDATE transactions
          SET (amount, date_time)
          = ($2,S3)
          WHERE id = $1
          "
    values = [@id,@amount,@date_time]
    SqlRunner.run( sql, values )
  end

  def delete
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  # Class methods
  def self.find_by_id(id)
    sql = "SELECT FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )[0]
    return Transaction.new(result)
  end

  def self.filter_by_amount(min,max)
    sql = "SELECT FROM transactions
     WHERE amount = $1"
    values = [min,max]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.filter_by_date(start, nd)
    sql = "SELECT FROM transactions
          WHERE date_time = $1"
    values = [start,nd]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.filter_by_refund(refund_bool)
    sql = "SELECT FROM transactions
          WHERE refund = $1"
    values = [refund_bool]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.all
    sql = "SELECT FROM transactions"
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end

end
require_relative '../db/sql_runner.rb'

class Transaction
  attr_accessor :id, :amount, :date_time, :refund

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @amount = options['amount'].to_i
    @date_time = options['date_time'] if options['date_time']
    @refund = options['refund']
  end

#Instance methods
  def save
    sql = "INSERT INTO transactions
          (amount,date_time)
          VALUES($1,$2)
          RETURNING *
          "
    values = [@amount,Time.now.utc]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id']
    @date_time = result[0]['date_time']
  end

  def sales
    sql = "SELECT FROM sales WHERE id = $1"
    values = [@amount]
    result = SqlRunner.run( sql, values )[0]
    return Customer.new(result)
  end

  def update
    sql = "UPDATE transactions
          SET (amount, date_time)
          = ($2,S3)
          WHERE id = $1
          "
    values = [@id,@amount,@date_time]
    SqlRunner.run( sql, values )
  end

  def delete
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  # Class methods
  def self.find_by_id(id)
    sql = "SELECT FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )[0]
    return Transaction.new(result)
  end

  def self.filter_by_amount(min,max)
    sql = "SELECT FROM transactions
     WHERE amount = $1"
    values = [min,max]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.filter_by_date(start, nd)
    sql = "SELECT FROM transactions
          WHERE date_time = $1"
    values = [start,nd]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.filter_by_refund(refund_bool)
    sql = "SELECT FROM transactions
          WHERE refund = $1"
    values = [refund_bool]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.all
    sql = "SELECT FROM transactions"
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Transaction.new(order) }
  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end

end
