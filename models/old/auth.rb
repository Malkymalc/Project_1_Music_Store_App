require_relative '../db/sql_runner.rb'

class Auth

  def find(params)
    sql = "SELECT * FROM staff
          WHERE email = $1 AND password = $2
          "
    values = [params['email'],params['password']]
    result_staff = SqlRunner.run( sql, values )[0]

    sql = "SELECT * FROM customers
          WHERE email = $1 AND password = $2
          "
    values = [params['email'],params['password']]
    result_customer = SqlRunner.run( sql, values )[0]

    return Customer.new(result_customer) if result_customer['customer']
    return Staff.new(result_staff) if result_staff['staff']
    return false
  end


  def reset(params)
    sql = "SELECT * FROM staff
          WHERE email = $1
          "
    values = [params['email']]
    result_staff = SqlRunner.run( sql, values )[0]

    sql = "SELECT * FROM customers
          WHERE email = $1
          "
    values = [params['email']]
    result_customer = SqlRunner.run( sql, values )[0]

    user = Customer.new(result_customer) if result_customer['customer']
    user = Staff.new(result_staff) if result_staff['staff']
    user = nil if !result_staff['staff'] || !result_customer['customer']
    Auth.reset_email(user)
  end

  def self.reset_email(user)
    return if user == nil
    #send an email!?
  end

end
