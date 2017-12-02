require_relative '../db/sql_runner.rb'

class Customer
  attr_accessor :id, :email, :password :first_name, :last_name, :customer, :address, :phone

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @email = options['email']
    @password = options['password']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @customer = true
    @address = options['address']
    @phone = options['phone']
  end

#Instance methods
  def save
    sql = "INSERT INTO customers
          (email, password, first_name, last_name, customer, address, phone)
          VALUES($1,$2,$3,$4,$5,$6,$7)
          RETURNING *
          "
    values = [@email, @password, @first_name, @last_name, @customer, @address, @phone]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id']
  end

  def orders
    sql = "SELECT FROM orders WHERE customer_id = $1"
    values = [@id]
    result = SqlRunner.run( sql, values )
    return result.map { |order| Order.new(order) }
  end

  def update
    sql = "UPDATE customers
          SET (email,password, first_name, last_name, customer)
          = ($2,S3,$4,$5,$6,$7,$8)
          WHERE id = $1
          "
    values = [@id, @email, @password, @first_name, @last_name, @customer, @address, @phone]
    SqlRunner.run( sql, values )
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  # Class methods
  def self.find_by_id(id)
    sql = "SELECT FROM customers WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )[0]
    return Customer.new(result)
  end

  def self.find_by_email(email)
    sql = "SELECT FROM customers WHERE email = $1"
    values = [email]
    result = SqlRunner.run( sql, values )
    return result.map { |customer|  Customer.new(customer) }
  end

  def self.find_by_phone(phone)
    sql = "SELECT FROM customers
          WHERE phone = $1"
    values = [phone]
    result = SqlRunner.run( sql, values )
    return result.map { |customer|  Customer.new(customer) }
  end

  def self.all
    sql = "SELECT FROM customers"
    result = SqlRunner.run( sql, values )
    return result.map { |customer|  Customer.new(customer) }
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run( sql )
  end

end
