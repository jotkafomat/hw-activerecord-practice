require 'sqlite3'
require 'active_record'
require 'byebug'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'customers.sqlite3')

class Customer < ActiveRecord::Base
  def to_s
    "  [#{id}] #{first} #{last}, <#{email}>, #{birthdate.strftime('%Y-%m-%d')}"
  end

  #  NOTE: Every one of these can be solved entirely by ActiveRecord calls.
  #  You should NOT need to call Ruby library functions for sorting, filtering, etc.

  def self.any_candice
    Customer.where("first == 'Candice'")
  end
  def self.with_valid_email
    Customer.where("email LIKE '%@%'")
  end

  def self.with_dot_org_email
    Customer.where("email LIKE '%.org%'")
  end

  def self.with_invalid_email
    Customer.where("email NOT LIKE '%@%'")
  end
  def self.with_blank_email
  Customer.where("TRIM(email) IS NULL")
end

end
