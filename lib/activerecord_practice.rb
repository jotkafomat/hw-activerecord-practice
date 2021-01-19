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

def self.born_before_1980
  Customer.where("birthdate < '1980-01-01'")
end

def self.with_valid_email_and_born_before_1980
  Customer.where("email LIKE '%@%' AND birthdate < '1980-01-01' ")
end

def self.last_names_starting_with_b
  Customer.where("last LIKE 'B%'").order('birthdate')
end

def self.twenty_youngest
  Customer.order("birthdate DESC").limit(20)
end

def self.update_gussie_murray_birthdate
  Customer.where(first: "Gussie", last: "Murray").update(birthdate: "2004-02-08")
end

def self.change_all_invalid_emails_to_blank
Customer.where("email != '' AND email IS NOT NULL and email NOT LIKE '%@%'").update_all(email: "")
end

end
