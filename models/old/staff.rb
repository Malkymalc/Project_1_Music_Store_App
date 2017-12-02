require_relative '../db/sql_runner.rb'

class Staff
  attr_accessor :id, :email, :password :first_name, :last_name, :staff

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @email = options['email']
    @password = options['password']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @staff = true
  end

#Instance methods
  def save
    sql = "INSERT INTO staff
          (email,password, first_name, last_name, staff)
          VALUES($1,$2,$3,$4,$5)
          RETURNING *
          "
    values = [@email,@password,@first_name,@last_name,@staff]
    result = SqlRunner.run( sql, values )
    @id = result[0]['id']
  end

  # def orders
  #   sql = "SELECT FROM staff WHERE staff_id = $1"
  #   values = [@id]
  #   result = SqlRunner.run( sql, values )
  #   return result.map { |order| Order.new(order) }
  # end

  def update
    sql = "UPDATE staff
          SET (email,password, first_name, last_name, staff)
          = ($2,S3,$4,$5,$6)
          WHERE id = $1
          "
    values = [@id,@email,@password,@first_name,@last_name,@staff]
    SqlRunner.run( sql, values )
  end

  def delete
    sql = "DELETE FROM staff WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  # Class methods
  def self.find_by_id(id)
    sql = "SELECT FROM staff WHERE id = $1"
    values = [id]
    result = SqlRunner.run( sql, values )[0]
    return Staff.new(result)
  end

  # def self.find_by_staff(staff_id)
  #   sql = "SELECT FROM staffs WHERE staff_id = $1"
  #   values = [staff_id]
  #   result = SqlRunner.run( sql, values )
  #   return result.map { |order|  Order.new(order) }
  # end
  #
  # def self.find_by_date(start, end)
  #   sql = "SELECT FROM staffs
  #         WHERE id = $1"
  #   values = [id]
  #   result = SqlRunner.run( sql, values )
  #   return result.map { |order|  Order.new(order) }
  # end

  def self.all
    sql = "SELECT FROM staff"
    result = SqlRunner.run( sql, values )
    return result.map { |staff|  Staff.new(staff) }
  end

  def self.delete_all
    sql = "DELETE FROM staff"
    SqlRunner.run( sql )
  end

end
