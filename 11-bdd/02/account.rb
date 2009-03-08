#

class Account
  attr_accessor :balance

  def initialize(amount)
    @balance = amount.to_f
  end

  def transfer_to(account, amount)
    @balance = @balance - amount.to_f
    account.balance = account.balance.to_f + amount.to_f
  end
end
