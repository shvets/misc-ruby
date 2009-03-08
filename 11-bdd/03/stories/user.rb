#

class User
  attr_accessor :username, :password, :email

  #USERS = { 'jdoe' => {:password => 'p', :email => 'em'}}
  USERS = {}

  def initialize username, password, email = nil
#, email = nil
    @username = username
    @password = password
    @email = email

    USERS[username] = { :password => password, :email => email }
  end

  def self.find_by_login login
    USERS[login]
  end
end
