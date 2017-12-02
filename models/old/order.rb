require_relative '../db/sql_runner.rb'

class Order
  attr_accessor :id, :customer_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @date_time = options['date_time'] if options['date_time']
  end

#Instance methods
  def save
    sql = "INSERT INTO orders
          (customer_id,date_time)
          VALUES($1,$2)
          RETURNING *
          "
    values = [@customer_id,Time.now.utc]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id']
    @date_time = result[0]['date_time']
  end

  def customer
    sql = "SELECT FROM customers WHERE id = $1"
    values = [@customer_id]
    result = SqlRunner.run( sql, values )[0]
    return Customer.new(result)
  end

  def update
    sql = "UPDATE orders
          SET (customer_id, date_time)
          = ($2,S3)
          WHERE id = $1
          "
    values = [@id,@customer_id,@date_time]
    SqlRunner.run( sql, values )
  end

  def delete
    sql = "DELETE FROM orders WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  # Class methods
  def self.find_by_id(id)
    sql = "SELECT FROM orders WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )[0]
    return Order.new(result)
  end

  def self.find_by_customer(customer_id)
    sql = "SELECT FROM orders WHERE customer_id = $1"
    values = [customer_id]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Order.new(order) }
  end

  def self.find_by_date(start, end)
    sql = "SELECT FROM orders
          WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Order.new(order) }
  end

  def self.all
    sql = "SELECT FROM orders"
    result = SqlRunner.run( sql, values )
    return result.map { |order|  Order.new(order) }
  end

  def self.delete_all
    sql = "DELETE FROM orders"
    SqlRunner.run( sql )
  end

end
