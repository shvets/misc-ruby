#

class User
  attr_accessor :username, :password, :email

  USERS = { 'jdoe' => {:password => 'correct', :email => 'name@url.com', :logged_in => false}}

  def initialize username, password, email = nil
    @username = username
    @password = password
    @email = email

    USERS[username] = { :password => password, :email => email }
  end

  def self.find_by_username username
    USERS[username]
  end

  def self.login username, password
    user = USERS[username]
    if user[:password] == password
      user[:logged_in] = true
      true
    else
      false
    end
  end

  def self.logout username
    USERS[username][:logged_in] = false
  end

end
